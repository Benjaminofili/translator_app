// lib/features/text_to_speech/data/models/speech_output_model.dart

class SpeechOutputModel {
  final String text;
  final String audioPath;
  final double processingTimeMs;
  final String voiceId; // e.g. "en_female"

  const SpeechOutputModel({
    required this.text,
    required this.audioPath,
    required this.processingTimeMs,
    required this.voiceId,
  });

  factory SpeechOutputModel.fromJson(Map<String, dynamic> json) {
    return SpeechOutputModel(
      text: json['text'] ?? '',
      audioPath: json['audioPath'] ?? '',
      processingTimeMs: (json['processingTimeMs'] ?? 0).toDouble(),
      voiceId: json['voiceId'] ?? 'default',
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'audioPath': audioPath,
    'processingTimeMs': processingTimeMs,
    'voiceId': voiceId,
  };
}
