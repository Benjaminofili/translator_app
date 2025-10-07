// lib/features/speech_to_text/data/models/transcription_model.dart

class TranscriptionModel {
  final String audioPath;
  final String recognizedText;
  final double confidence;
  final Duration duration;
  final DateTime createdAt;

  const TranscriptionModel({
    required this.audioPath,
    required this.recognizedText,
    required this.confidence,
    required this.duration,
    required this.createdAt,
  });

  factory TranscriptionModel.fromJson(Map<String, dynamic> json) {
    return TranscriptionModel(
      audioPath: json['audioPath'] ?? '',
      recognizedText: json['recognizedText'] ?? '',
      confidence: (json['confidence'] ?? 1.0).toDouble(),
      duration: Duration(milliseconds: json['duration'] ?? 0),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() => {
    'audioPath': audioPath,
    'recognizedText': recognizedText,
    'confidence': confidence,
    'duration': duration.inMilliseconds,
    'createdAt': createdAt.toIso8601String(),
  };
}
