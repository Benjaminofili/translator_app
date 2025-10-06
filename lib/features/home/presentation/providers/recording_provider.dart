import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../history/data/repositories/history_repository_impl.dart';
import '../../../history/domain/entities/translation_history.dart';
import 'package:uuid/uuid.dart';
import 'language_provider.dart';

part 'recording_provider.g.dart';

@riverpod
class Recording extends _$Recording {
  @override
  RecordingState build() {
    return const RecordingState(
      isRecording: false,
      transcribedText: '',
      translatedText: '',
      waveformAmplitudes: [],
    );
  }

  void startRecording() {
    state = state.copyWith(
      isRecording: true,
      transcribedText: '',
      translatedText: '',
      waveformAmplitudes: [],
    );

    // TODO: Integrate STT service
    _simulateTranscription();
    _simulateWaveform();
  }

  void stopRecording() {
    state = state.copyWith(
      isRecording: false,
      waveformAmplitudes: [],
    );
    // TODO: Stop STT service
  }

  void setTranscription(String text) {
    state = state.copyWith(transcribedText: text);
  }

  Future<void> setTranslation(String text) async {
    state = state.copyWith(translatedText: text);
    // Save to history when translation is set
    if (state.transcribedText.isNotEmpty && text.isNotEmpty) {
      await _saveToHistory(state.transcribedText, text);
    }
  }

  void clearTexts() {
    state = state.copyWith(
      transcribedText: '',
      translatedText: '',
      waveformAmplitudes: [],
    );
  }

  void updateWaveform(List<double> amplitudes) {
    state = state.copyWith(waveformAmplitudes: amplitudes);
  }

  // Save translation to history
  Future<void> _saveToHistory(String source, String translated) async {
    final repository = HistoryRepositoryImpl();
    // Note: languageSelectionProvider is not defined in the provided code
    // Assuming it's available in the app's provider setup
    final languages = ref.read(languageSelectionProvider).value;

    if (languages != null) {
      await repository.addHistory(
        TranslationHistory(
          id: const Uuid().v4(),
          sourceText: source,
          translatedText: translated,
          sourceLanguage: languages.from,
          targetLanguage: languages.to,
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  // Temporary simulation
  Future<void> _simulateTranscription() async {
    await Future.delayed(const Duration(seconds: 2));
    if (state.isRecording) {
      setTranscription('Hello, how are you today?');
      await setTranslation('Hola, ¿cómo estás hoy?');
    }
  }

  void _simulateWaveform() {
    if (!state.isRecording) return;

    Future.delayed(const Duration(milliseconds: 80), () {
      if (state.isRecording) {
        final random = math.Random();
        final amplitudes = List.generate(
          40,
              (i) => 0.1 + random.nextDouble() * 0.9,
        );
        updateWaveform(amplitudes);
        _simulateWaveform();
      }
    });
  }
}

class RecordingState {
  final bool isRecording;
  final String transcribedText;
  final String translatedText;
  final List<double> waveformAmplitudes;

  const RecordingState({
    required this.isRecording,
    required this.transcribedText,
    required this.translatedText,
    this.waveformAmplitudes = const [],
  });

  RecordingState copyWith({
    bool? isRecording,
    String? transcribedText,
    String? translatedText,
    List<double>? waveformAmplitudes,
  }) {
    return RecordingState(
      isRecording: isRecording ?? this.isRecording,
      transcribedText: transcribedText ?? this.transcribedText,
      translatedText: translatedText ?? this.translatedText,
      waveformAmplitudes: waveformAmplitudes ?? this.waveformAmplitudes,
    );
  }
}