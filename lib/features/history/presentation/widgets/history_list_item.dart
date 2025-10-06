import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/translation_history.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_colors.dart';

class HistoryListItem extends StatelessWidget {
  final TranslationHistory history;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final VoidCallback onDelete;

  const HistoryListItem({
    super.key,
    required this.history,
    required this.onTap,
    required this.onFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Languages and actions
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.sourceLanguage.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: Text(
                      history.sourceLanguage,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.sourceLanguage,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.targetLanguage.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: Text(
                      history.targetLanguage,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.targetLanguage,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      history.isFavorite ? Icons.star : Icons.star_border,
                      color: history.isFavorite ? Colors.amber : AppColors.textTertiary,
                    ),
                    onPressed: onFavorite,
                    iconSize: 20,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    onPressed: onDelete,
                    iconSize: 20,
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.only(left: AppTheme.spacingSm),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingMd),

              // Source text
              Text(
                history.sourceText,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: AppTheme.spacingSm),

              // Translation
              Text(
                history.translatedText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: AppTheme.spacingMd),

              // Timestamp
              Text(
                dateFormat.format(history.timestamp),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}