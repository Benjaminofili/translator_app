// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for managing input mode state
///
/// This controls which input method is currently active:
/// - Voice: Speech-to-text translation
/// - Text: Keyboard input translation
/// - Camera: OCR-based translation (future feature)

@ProviderFor(InputModeSelection)
const inputModeSelectionProvider = InputModeSelectionProvider._();

/// Provider for managing input mode state
///
/// This controls which input method is currently active:
/// - Voice: Speech-to-text translation
/// - Text: Keyboard input translation
/// - Camera: OCR-based translation (future feature)
final class InputModeSelectionProvider
    extends $NotifierProvider<InputModeSelection, InputMode> {
  /// Provider for managing input mode state
  ///
  /// This controls which input method is currently active:
  /// - Voice: Speech-to-text translation
  /// - Text: Keyboard input translation
  /// - Camera: OCR-based translation (future feature)
  const InputModeSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inputModeSelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inputModeSelectionHash();

  @$internal
  @override
  InputModeSelection create() => InputModeSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InputMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InputMode>(value),
    );
  }
}

String _$inputModeSelectionHash() =>
    r'18144a51cb1967c232fb1c76c495634412ab2859';

/// Provider for managing input mode state
///
/// This controls which input method is currently active:
/// - Voice: Speech-to-text translation
/// - Text: Keyboard input translation
/// - Camera: OCR-based translation (future feature)

abstract class _$InputModeSelection extends $Notifier<InputMode> {
  InputMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<InputMode, InputMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InputMode, InputMode>,
              InputMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
