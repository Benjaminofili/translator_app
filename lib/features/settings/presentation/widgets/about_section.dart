import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// About Section Widget
///
/// Displays app information, including version, privacy policy, licenses, and GitHub repository.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: AppColors.primary,
            ),
            title: const Text('Version'),
            subtitle: const Text('1.0.0 (Build 1)'),
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: AppColors.primary,
            ),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new_rounded, size: 18),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening privacy policy...'),
                ),
              );
            },
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Icon(
              Icons.description_outlined,
              color: AppColors.primary,
            ),
            title: const Text('Open Source Licenses'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: 'AI Voice Translator',
                applicationVersion: '1.0.0',
              );
            },
          ),
          const Divider(height: 1, indent: 72),
          ListTile(
            leading: Icon(
              Icons.code_rounded,
              color: AppColors.primary,
            ),
            title: const Text('GitHub Repository'),
            trailing: const Icon(Icons.open_in_new_rounded, size: 18),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening GitHub...'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}