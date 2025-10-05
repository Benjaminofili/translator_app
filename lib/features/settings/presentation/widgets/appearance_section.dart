import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme-provider.dart';
import '../../../../core/theme/app_colors.dart';

/// Appearance Section Widget
///
/// Manages the theme toggle for switching between light and dark modes.
class AppearanceSection extends ConsumerWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeModeAsync = ref.watch(appThemeModeProvider);

    return Card(
      child: themeModeAsync.when(
        loading: () => const ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Loading theme...'),
        ),
        error: (_, __) => const ListTile(
          leading: Icon(Icons.error_outline),
          title: Text('Error loading theme'),
        ),
        data: (isDark) => SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Use dark theme'),
          secondary: Icon(
            isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            color: AppColors.primary,
          ),
          value: isDark,
          onChanged: (value) {
            ref.read(appThemeModeProvider.notifier).setDarkMode(value);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       value ? 'Dark mode enabled' : 'Light mode enabled',
            //     ),
            //     duration: const Duration(seconds: 2),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}