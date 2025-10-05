import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Languages Section Widget
///
/// Manages language model settings, including downloaded models, available languages,
/// and storage usage.
class LanguagesSection extends StatelessWidget {
  const LanguagesSection({super.key});

  void _showDownloadedModelsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Downloaded Models'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildModelItem(context, 'English - Spanish', '150 MB'),
            const SizedBox(height: AppTheme.spacingSm),
            _buildModelItem(context, 'English - French', '145 MB'),
            const SizedBox(height: AppTheme.spacingSm),
            _buildModelItem(context, 'English - German', '155 MB'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildModelItem(BuildContext context, String name, String size) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: AppColors.success, size: 20),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Text(
          size,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
          'This will clear temporary translation data and free up storage space. Downloaded language models will not be affected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Cache cleared successfully'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.download_rounded,
              color: AppColors.primary,
            ),
            title: const Text('Downloaded Models'),
            subtitle: const Text('3 language pairs'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _showDownloadedModelsDialog(context),
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Icon(
              Icons.language_rounded,
              color: AppColors.primary,
            ),
            title: const Text('Available Languages'),
            subtitle: const Text('Manage language packs'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Language management coming soon'),
                ),
              );
            },
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Icon(
              Icons.storage_rounded,
              color: AppColors.primary,
            ),
            title: const Text('Storage Usage'),
            subtitle: const Text('~450 MB'),
            trailing: TextButton(
              onPressed: () => _showClearCacheDialog(context),
              child: const Text('Clear Cache'),
            ),
          ),
        ],
      ),
    );
  }
}