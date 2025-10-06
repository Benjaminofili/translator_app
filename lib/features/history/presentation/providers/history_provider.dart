import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/translation_history.dart';
import '../../data/repositories/history_repository_impl.dart';

part 'history_provider.g.dart';

@riverpod
class History extends _$History {
  late final HistoryRepositoryImpl _repository;

  @override
  Future<List<TranslationHistory>> build() async {
    _repository = HistoryRepositoryImpl();
    return await _repository.getAllHistory();
  }

  Future<void> addHistory(TranslationHistory history) async {
    await _repository.addHistory(history);
    ref.invalidateSelf();
  }

  Future<void> deleteHistory(String id) async {
    await _repository.deleteHistory(id);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    await _repository.clearAllHistory();
    ref.invalidateSelf();
  }

  Future<void> toggleFavorite(String id) async {
    await _repository.toggleFavorite(id);
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<TranslationHistory>> favorites(FavoritesRef ref) async {
  final repository = HistoryRepositoryImpl();
  return await repository.getFavorites();
}