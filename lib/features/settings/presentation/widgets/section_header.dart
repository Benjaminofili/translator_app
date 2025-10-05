import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Reusable Section Header Widget
///
/// Displays a section title with consistent styling for settings sections.
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}