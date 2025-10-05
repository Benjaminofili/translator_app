import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recording_provider.g.dart';

@riverpod
class Recording extends _$Recording {
  @override
  RecordingState build() {
    return const RecordingState(
      isRecording: false,
      transcribedText: '',
      translatedText: '',
    );
  }

  void startRecording() {
    state = state.copyWith(
      isRecording: true,
      transcribedText: '',
      translatedText: '',
    );

    // TODO: Integrate STT service
    _simulateTranscription();
  }

  void stopRecording() {
    state = state.copyWith(isRecording: false);
    // TODO: Stop STT service
  }

  void setTranscription(String text) {
    state = state.copyWith(transcribedText: text);
  }

  void setTranslation(String text) {
    state = state.copyWith(translatedText: text);
  }

  void clearTexts() {
    state = state.copyWith(
      transcribedText: '',
      translatedText: '',
    );
  }

  // Temporary simulation
  Future<void> _simulateTranscription() async {
    await Future.delayed(const Duration(seconds: 2));
    if (state.isRecording) {
      setTranscription('Hello, how are you today?');
      setTranslation('Hola, ¿cómo estás hoy?');
    }
  }
}

class RecordingState {
  final bool isRecording;
  final String transcribedText;
  final String translatedText;

  const RecordingState({
    required this.isRecording,
    required this.transcribedText,
    required this.translatedText,
  });

  RecordingState copyWith({
    bool? isRecording,
    String? transcribedText,
    String? translatedText,
  }) {
    return RecordingState(
      isRecording: isRecording ?? this.isRecording,
      transcribedText: transcribedText ?? this.transcribedText,
      translatedText: translatedText ?? this.translatedText,
    );
  }
}