import 'package:hive_flutter/hive_flutter.dart';
import '../../features/history/data/models/translation_history_model.dart';

/// Hive Initialization Service
///
/// Initializes Hive and registers type adapters
///
/// Path: lib/core/services/hive_service.dart
class HiveService {
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TranslationHistoryModelAdapter());
    }
  }

  static Future<void> close() async {
    await Hive.close();
  }
}