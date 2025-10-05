import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/recording_provider.dart';

class LanguageSelectorHeader extends ConsumerWidget {
  const LanguageSelectorHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageAsync = ref.watch(languageSelectionProvider);

    return languageAsync.when(
      loading: () => const _LoadingHeader(),
      error: (_, __) => const _ErrorHeader(),
      data: (languages) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _LanguageButton(
                language: languages.from,
                onTap: () => _showLanguagePicker(
                  context,
                  ref,
                  isFrom: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm),
              child: IconButton(
                icon: const Icon(Icons.swap_horiz),
                onPressed: () {
                  ref.read(languageSelectionProvider.notifier).swapLanguages();
                  final recording = ref.read(recordingProvider.notifier);
                  final currentState = ref.read(recordingProvider);
                  recording.setTranscription(currentState.translatedText);
                  recording.setTranslation(currentState.transcribedText);
                },
                color: AppColors.sourceLanguage,
              ),
            ),
            Expanded(
              child: _LanguageButton(
                language: languages.to,
                onTap: () => _showLanguagePicker(
                  context,
                  ref,
                  isFrom: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(
      BuildContext context,
      WidgetRef ref,
      {required bool isFrom}
      ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Select ${isFrom ? 'Source' : 'Target'} Language',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: availableLanguages.length,
                itemBuilder: (context, index) {
                  final lang = availableLanguages[index];
                  final currentLang = ref.read(languageSelectionProvider).value;
                  final isSelected = isFrom
                      ? lang == currentLang?.from
                      : lang == currentLang?.to;

                  return ListTile(
                    title: Text(lang),
                    trailing: isSelected
                        ? Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                    )
                        : null,
                    selected: isSelected,
                    selectedTileColor: AppColors.primaryContainer.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    onTap: () {
                      if (isFrom) {
                        ref.read(languageSelectionProvider.notifier)
                            .setFromLanguage(lang);
                      } else {
                        ref.read(languageSelectionProvider.notifier)
                            .setToLanguage(lang);
                      }
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String language;
  final VoidCallback onTap;

  const _LanguageButton({
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: AppTheme.spacingMd,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: AppTheme.iconSizeMd,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingHeader extends StatelessWidget {
  const _LoadingHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorHeader extends StatelessWidget {
  const _ErrorHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Center(
        child: Text(
          'Error loading languages',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.error,
          ),
        ),
      ),
    );
  }
}