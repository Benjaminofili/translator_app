import 'package:hive/hive.dart';
import '../../domain/entities/translation_history.dart';

part 'translation_history_model.g.dart';

@HiveType(typeId: 0)
class TranslationHistoryModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String sourceText;

  @HiveField(2)
  final String translatedText;

  @HiveField(3)
  final String sourceLanguage;

  @HiveField(4)
  final String targetLanguage;

  @HiveField(5)
  final DateTime timestamp;

  @HiveField(6)
  final bool isFavorite;

  TranslationHistoryModel({
    required this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.timestamp,
    this.isFavorite = false,
  });

  factory TranslationHistoryModel.fromEntity(TranslationHistory entity) {
    return TranslationHistoryModel(
      id: entity.id,
      sourceText: entity.sourceText,
      translatedText: entity.translatedText,
      sourceLanguage: entity.sourceLanguage,
      targetLanguage: entity.targetLanguage,
      timestamp: entity.timestamp,
      isFavorite: entity.isFavorite,
    );
  }

  TranslationHistory toEntity() {
    return TranslationHistory(
      id: id,
      sourceText: sourceText,
      translatedText: translatedText,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      timestamp: timestamp,
      isFavorite: isFavorite,
    );
  }
}