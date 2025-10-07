// lib/features/translation/data/models/translation_model.dart

class TranslationModel {
  final String sourceText;
  final String translatedText;
  final String sourceLangCode;
  final String targetLangCode;
  final double latencyMs;
  final double confidence;

  const TranslationModel({
    required this.sourceText,
    required this.translatedText,
    required this.sourceLangCode,
    required this.targetLangCode,
    required this.latencyMs,
    required this.confidence,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      sourceText: json['sourceText'] ?? '',
      translatedText: json['translatedText'] ?? '',
      sourceLangCode: json['sourceLangCode'] ?? 'en',
      targetLangCode: json['targetLangCode'] ?? 'es',
      latencyMs: (json['latencyMs'] ?? 0).toDouble(),
      confidence: (json['confidence'] ?? 1.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'sourceText': sourceText,
    'translatedText': translatedText,
    'sourceLangCode': sourceLangCode,
    'targetLangCode': targetLangCode,
    'latencyMs': latencyMs,
    'confidence': confidence,
  };
}
