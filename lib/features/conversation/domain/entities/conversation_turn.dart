// lib/features/conversation/domain/entities/conversation_turn.dart

enum Speaker { user, partner }

class ConversationTurn {
  final Speaker speaker;
  final String originalSpeechPath;
  final String recognizedText;
  final String translatedText;
  final String translatedSpeechPath;
  final DateTime timestamp;

  const ConversationTurn({
    required this.speaker,
    required this.originalSpeechPath,
    required this.recognizedText,
    required this.translatedText,
    required this.translatedSpeechPath,
    required this.timestamp,
  });
}
