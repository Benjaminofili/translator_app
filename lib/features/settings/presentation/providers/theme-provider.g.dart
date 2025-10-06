// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme-provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeModeHash() => r'9771d3332fb2da4f231df1d2db8c97c4e99a4c08';

/// Theme mode provider
///
/// Manages app theme (light/dark mode) and persists user preference
///
/// Path: lib/features/settings/presentation/providers/theme_provider.dart
///
/// Copied from [AppThemeMode].
@ProviderFor(AppThemeMode)
final appThemeModeProvider =
    AutoDisposeAsyncNotifierProvider<AppThemeMode, bool>.internal(
  AppThemeMode.new,
  name: r'appThemeModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appThemeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppThemeMode = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
