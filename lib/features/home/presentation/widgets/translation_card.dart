import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class TranslationCard extends StatelessWidget {
  final String title;
  final String text;
  final bool isSource;
  final bool isListening;

  const TranslationCard({
    super.key,
    required this.title,
    required this.text,
    required this.isSource,
    this.isListening = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 120),
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSource
                        ? AppColors.sourceLanguage.withOpacity(0.1)
                        : AppColors.targetLanguage.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isSource
                          ? AppColors.sourceLanguage
                          : AppColors.targetLanguage,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isListening) ...[
                  const SizedBox(width: AppTheme.spacingSm),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.translating,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text(
              text.isEmpty
                  ? (isSource
                  ? 'Tap microphone to start...'
                  : 'Translation will appear here...')
                  : text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: text.isEmpty
                    ? Theme.of(context).colorScheme.outline
                    : Theme.of(context).colorScheme.onSurface,
                height: 1.5,
              ),
            ),
            if (text.isNotEmpty && !isSource) ...[
              const SizedBox(height: AppTheme.spacingMd),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.volume_up),
                    iconSize: AppTheme.iconSizeMd,
                    onPressed: () {
                      // TODO: Implement TTS
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('TTS coming soon')),
                      );
                    },
                    tooltip: 'Play audio',
                    color: AppColors.info,
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    iconSize: AppTheme.iconSizeMd,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard'),
                          backgroundColor: AppColors.success,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    tooltip: 'Copy text',
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}