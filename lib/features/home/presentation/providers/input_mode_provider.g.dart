// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inputModeSelectionHash() =>
    r'18144a51cb1967c232fb1c76c495634412ab2859';

/// Provider for managing input mode state
///
/// This controls which input method is currently active:
/// - Voice: Speech-to-text translation
/// - Text: Keyboard input translation
/// - Camera: OCR-based translation (future feature)
///
/// Copied from [InputModeSelection].
@ProviderFor(InputModeSelection)
final inputModeSelectionProvider =
    AutoDisposeNotifierProvider<InputModeSelection, InputMode>.internal(
  InputModeSelection.new,
  name: r'inputModeSelectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inputModeSelectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InputModeSelection = AutoDisposeNotifier<InputMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
