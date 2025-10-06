import '../entities/translation_history.dart';

abstract class HistoryRepository {
  Future<List<TranslationHistory>> getAllHistory();
  Future<List<TranslationHistory>> getFavorites();
  Future<void> addHistory(TranslationHistory history);
  Future<void> deleteHistory(String id);
  Future<void> clearAllHistory();
  Future<void> toggleFavorite(String id);
}