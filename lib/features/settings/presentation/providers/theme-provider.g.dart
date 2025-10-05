// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme-provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Theme mode provider
///
/// Manages app theme (light/dark mode) and persists user preference
///
/// Path: lib/features/settings/presentation/providers/theme_provider.dart

@ProviderFor(AppThemeMode)
const appThemeModeProvider = AppThemeModeProvider._();

/// Theme mode provider
///
/// Manages app theme (light/dark mode) and persists user preference
///
/// Path: lib/features/settings/presentation/providers/theme_provider.dart
final class AppThemeModeProvider
    extends $AsyncNotifierProvider<AppThemeMode, bool> {
  /// Theme mode provider
  ///
  /// Manages app theme (light/dark mode) and persists user preference
  ///
  /// Path: lib/features/settings/presentation/providers/theme_provider.dart
  const AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  AppThemeMode create() => AppThemeMode();
}

String _$appThemeModeHash() => r'9771d3332fb2da4f231df1d2db8c97c4e99a4c08';

/// Theme mode provider
///
/// Manages app theme (light/dark mode) and persists user preference
///
/// Path: lib/features/settings/presentation/providers/theme_provider.dart

abstract class _$AppThemeMode extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
