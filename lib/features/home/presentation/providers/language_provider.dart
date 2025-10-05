import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/onboarding_service.dart';

part 'language_provider.g.dart';

@riverpod
class LanguageSelection extends _$LanguageSelection {
  @override
  Future<LanguagePair> build() async {
    final langs = await OnboardingService.getLanguageSelection();
    return LanguagePair(
      from: langs['from'] ?? 'English',
      to: langs['to'] ?? 'Spanish',
    );
  }

  Future<void> setFromLanguage(String language) async {
    final current = state.value;
    if (current != null) {
      final updated = current.copyWith(from: language);
      state = AsyncValue.data(updated);
      await OnboardingService.saveLanguageSelection(updated.from, updated.to);
    }
  }

  Future<void> setToLanguage(String language) async {
    final current = state.value;
    if (current != null) {
      final updated = current.copyWith(to: language);
      state = AsyncValue.data(updated);
      await OnboardingService.saveLanguageSelection(updated.from, updated.to);
    }
  }

  Future<void> swapLanguages() async {
    final current = state.value;
    if (current != null) {
      final updated = LanguagePair(from: current.to, to: current.from);
      state = AsyncValue.data(updated);
      await OnboardingService.saveLanguageSelection(updated.from, updated.to);
    }
  }
}

class LanguagePair {
  final String from;
  final String to;

  const LanguagePair({
    required this.from,
    required this.to,
  });

  LanguagePair copyWith({
    String? from,
    String? to,
  }) {
    return LanguagePair(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}

// Available languages constant
const availableLanguages = [
  'English',
  'Spanish',
  'French',
  'German',
  'Italian',
  'Portuguese',
  'Chinese',
  'Japanese',
  'Korean',
  'Arabic',
];