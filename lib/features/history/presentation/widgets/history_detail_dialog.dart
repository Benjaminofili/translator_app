import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/translation_history.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// History Detail Dialog
///
/// Shows full translation details with copy/share actions
///
/// Path: lib/features/history/presentation/widgets/history_detail_dialog.dart
class HistoryDetailDialog extends StatelessWidget {
  final TranslationHistory history;

  const HistoryDetailDialog({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM dd, yyyy • hh:mm a');
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with languages
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.sourceLanguage.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: Text(
                      history.sourceLanguage,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.sourceLanguage,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.targetLanguage.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: Text(
                      history.targetLanguage,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.targetLanguage,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingLg),

              // Source text section
              Text(
                'Original',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: SelectableText(
                  history.sourceText,
                  style: theme.textTheme.bodyLarge,
                ),
              ),

              const SizedBox(height: AppTheme.spacingLg),

              // Translation section
              Text(
                'Translation',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: SelectableText(
                  history.translatedText,
                  style: theme.textTheme.bodyLarge,
                ),
              ),

              const SizedBox(height: AppTheme.spacingLg),

              // Timestamp
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Text(
                    dateFormat.format(history.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingLg),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: history.translatedText),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Copied to clipboard'),
                            backgroundColor: AppColors.success,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded),
                      label: const Text('Copy'),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Share.share(
                          '${history.sourceText}\n\n→ ${history.translatedText}',
                        );
                      },
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Share'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingSm),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}