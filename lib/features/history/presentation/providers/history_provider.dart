import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/translation_history.dart';
import '../providers/repository_provider.dart';

part 'history_provider.g.dart';

@riverpod
class History extends _$History {
  @override
  Future<List<TranslationHistory>> build() async {
    final repository = ref.watch(historyRepositoryProvider);
    return await repository.getAllHistory();
  }

  Future<void> addHistory(TranslationHistory history) async {
    final repository = ref.read(historyRepositoryProvider);
    await repository.addHistory(history);
    ref.invalidateSelf();
  }

  Future<void> deleteHistory(String id) async {
    final repository = ref.read(historyRepositoryProvider);
    await repository.deleteHistory(id);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    final repository = ref.read(historyRepositoryProvider);
    await repository.clearAllHistory();
    ref.invalidateSelf();
  }

  Future<void> toggleFavorite(String id) async {
    final repository = ref.read(historyRepositoryProvider);
    await repository.toggleFavorite(id);
    ref.invalidateSelf();
  }
}

@riverpod
Future<List<TranslationHistory>> favorites(FavoritesRef ref) async {
  // Watch the main history to auto-update when favorites change
  ref.watch(historyProvider);

  final repository = ref.watch(historyRepositoryProvider);
  return await repository.getFavorites();
}