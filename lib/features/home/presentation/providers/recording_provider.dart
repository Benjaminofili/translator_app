import 'dart:math' as math;

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
      waveformAmplitudes: [], // NEW: Store waveform data
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
    _simulateWaveform(); // NEW: Start waveform animation
  }

  void stopRecording() {
    state = state.copyWith(
      isRecording: false,
      waveformAmplitudes: [], // Clear waveform
    );
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
      waveformAmplitudes: [],
    );
  }

  // NEW: Update waveform amplitudes
  void updateWaveform(List<double> amplitudes) {
    state = state.copyWith(waveformAmplitudes: amplitudes);
  }

  // Temporary simulation
  Future<void> _simulateTranscription() async {
    await Future.delayed(const Duration(seconds: 2));
    if (state.isRecording) {
      setTranscription('Hello, how are you today?');
      setTranslation('Hola, ¿cómo estás hoy?');
    }
  }

  // NEW: Simulate waveform data
  void _simulateWaveform() {
    if (!state.isRecording) return;

    Future.delayed(const Duration(milliseconds: 80), () {
      if (state.isRecording) {
        final random = math.Random();
        final amplitudes = List.generate(
          40,
              (i) {
            // Random amplitude between 0.1 and 1.0
            return 0.1 + random.nextDouble() * 0.9;
          },
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
  final List<double> waveformAmplitudes; // NEW

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