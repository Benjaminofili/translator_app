import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/recording_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class TranslationActions extends ConsumerWidget {
  const TranslationActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingProvider);
    final hasTranslation = recordingState.translatedText.isNotEmpty;

    if (!hasTranslation) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(
            icon: Icons.volume_up,
            label: 'Listen',
            onPressed: () {
              // TODO: Implement TTS
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TTS coming soon')),
              );
            },
          ),
          _ActionButton(
            icon: Icons.copy,
            label: 'Copy',
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: recordingState.translatedText),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Copied to clipboard'),
                  backgroundColor: AppColors.success,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          _ActionButton(
            icon: Icons.share,
            label: 'Share',
            onPressed: () async {
              await SharePlus.instance.share(
                ShareParams(
                  text: recordingState.translatedText,
                  title: 'Shared Translation',
                  subject: 'Translation from AI Voice Translator',
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppTheme.iconSizeMd,
              color: AppColors.primary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}