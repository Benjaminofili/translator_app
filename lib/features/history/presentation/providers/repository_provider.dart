import 'package:ai_voice_translator/features/history/data/repositories/history_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../repositories/history_repository_impl.dart';

part 'repository_provider.g.dart';

@riverpod
HistoryRepositoryImpl historyRepository(HistoryRepositoryRef ref) {
  return HistoryRepositoryImpl();
}