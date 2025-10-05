import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme-provider.g.dart';

/// Theme mode provider
/// 
/// Manages app theme (light/dark mode) and persists user preference
/// 
/// Path: lib/features/settings/presentation/providers/theme_provider.dart
@riverpod
class AppThemeMode  extends _$AppThemeMode  {
  static const String _key = 'theme_mode';

  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false; // false = light, true = dark
  }

  /// Toggle between light and dark mode
  Future<void> toggle() async {
    final current = state.value ?? false;
    final newValue = !current;
    
    state = AsyncValue.data(newValue);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, newValue);
  }

  /// Set specific theme mode
  Future<void> setDarkMode(bool isDark) async {
    state = AsyncValue.data(isDark);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
  }

  /// Get current theme mode
  bool get isDarkMode => state.value ?? false;
}