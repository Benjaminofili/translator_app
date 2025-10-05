import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input_mode_provider.g.dart';

/// Input mode for the translator
enum InputMode {
  voice,
  text,
  camera,
}

/// Provider for managing input mode state
///
/// This controls which input method is currently active:
/// - Voice: Speech-to-text translation
/// - Text: Keyboard input translation
/// - Camera: OCR-based translation (future feature)
@riverpod
class InputModeSelection extends _$InputModeSelection {
  @override
  InputMode build() {
    return InputMode.voice; // Default to voice mode
  }

  /// Set the input mode to voice
  void setVoice() {
    state = InputMode.voice;
  }

  /// Set the input mode to text
  void setText() {
    state = InputMode.text;
  }

  /// Set the input mode to camera
  void setCamera() {
    state = InputMode.camera;
    // TODO: Implement camera translation feature
  }

  /// Toggle between voice and text modes
  void toggle() {
    if (state == InputMode.voice) {
      state = InputMode.text;
    } else {
      state = InputMode.voice;
    }
  }
}

/// Extension to check current mode easily
extension InputModeExtension on InputMode {
  bool get isVoice => this == InputMode.voice;
  bool get isText => this == InputMode.text;
  bool get isCamera => this == InputMode.camera;

  String get displayName {
    switch (this) {
      case InputMode.voice:
        return 'Voice';
      case InputMode.text:
        return 'Text';
      case InputMode.camera:
        return 'Camera';
    }
  }
}