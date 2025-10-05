class Language {
  final String code;
  final String name;
  final String flag;
  final bool isDownloaded;

  const Language({
    required this.code,
    required this.name,
    required this.flag,
    this.isDownloaded = false,
  });

  Language copyWith({
    String? code,
    String? name,
    String? flag,
    bool? isDownloaded,
  }) {
    return Language(
      code: code ?? this.code,
      name: name ?? this.name,
      flag: flag ?? this.flag,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }
}

class LanguageConstants {
  static const languages = [
    Language(code: 'en', name: 'English', flag: '🇺🇸', isDownloaded: true),
    Language(code: 'es', name: 'Spanish', flag: '🇪🇸', isDownloaded: false),
    Language(code: 'fr', name: 'French', flag: '🇫🇷', isDownloaded: false),
    Language(code: 'de', name: 'German', flag: '🇩🇪', isDownloaded: false),
    Language(code: 'it', name: 'Italian', flag: '🇮🇹', isDownloaded: false),
    Language(code: 'pt', name: 'Portuguese', flag: '🇵🇹', isDownloaded: false),
    Language(code: 'ru', name: 'Russian', flag: '🇷🇺', isDownloaded: false),
    Language(code: 'zh', name: 'Chinese', flag: '🇨🇳', isDownloaded: false),
    Language(code: 'ja', name: 'Japanese', flag: '🇯🇵', isDownloaded: false),
    Language(code: 'ko', name: 'Korean', flag: '🇰🇷', isDownloaded: false),
  ];

  static Language getLanguage(String code) {
    return languages.firstWhere(
      (lang) => lang.code == code,
      orElse: () => languages[0],
    );
  }
}