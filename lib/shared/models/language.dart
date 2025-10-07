// lib/shared/models/language.dart

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
