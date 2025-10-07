import 'package:hive/hive.dart';
import '../../domain/entities/translation_history.dart';
import '../../domain/repositories/history_repository.dart';
import '../models/translation_history_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  static const String _boxName = 'translation_history';

  Future<Box<TranslationHistoryModel>> get _box async {
    // Check if box is already open
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<TranslationHistoryModel>(_boxName);
    }
    return await Hive.openBox<TranslationHistoryModel>(_boxName);
  }

  @override
  Future<List<TranslationHistory>> getAllHistory() async {
    final box = await _box;
    final models = box.values.toList();

    // Sort by timestamp, newest first
    models.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<TranslationHistory>> getFavorites() async {
    final box = await _box;
    final models = box.values.where((model) => model.isFavorite).toList();

    models.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addHistory(TranslationHistory history) async {
    final box = await _box;
    final model = TranslationHistoryModel.fromEntity(history);
    await box.put(history.id, model);
  }

  @override
  Future<void> deleteHistory(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  @override
  Future<void> clearAllHistory() async {
    final box = await _box;
    await box.clear();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final box = await _box;
    final model = box.get(id);

    if (model != null) {
      final updated = TranslationHistoryModel(
        id: model.id,
        sourceText: model.sourceText,
        translatedText: model.translatedText,
        sourceLanguage: model.sourceLanguage,
        targetLanguage: model.targetLanguage,
        timestamp: model.timestamp,
        isFavorite: !model.isFavorite,
      );
      await box.put(id, updated);
    }
  }
}