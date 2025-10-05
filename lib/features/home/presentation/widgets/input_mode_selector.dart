import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/input_mode_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Input Mode Selector Widget
///
/// Allows users to switch between different input methods:
/// - Voice: Speech-to-text translation
/// - Text: Keyboard input translation
/// - Camera: OCR-based translation (future feature)
///
/// Path: lib/features/home/presentation/widgets/input_mode_selector.dart
class InputModeSelector extends ConsumerWidget {
  const InputModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(inputModeSelectionProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Row(
        children: [
          _ModeButton(
            icon: Icons.mic_rounded,
            label: 'Voice',
            isSelected: currentMode == InputMode.voice,
            onTap: () {
              ref.read(inputModeSelectionProvider.notifier).setVoice();
              HapticFeedback.selectionClick();
            },
          ),
          _ModeButton(
            icon: Icons.keyboard_rounded,
            label: 'Text',
            isSelected: currentMode == InputMode.text,
            onTap: () {
              ref.read(inputModeSelectionProvider.notifier).setText();
              HapticFeedback.selectionClick();
            },
          ),
          _ModeButton(
            icon: Icons.camera_alt_rounded,
            label: 'Camera',
            isSelected: currentMode == InputMode.camera,
            onTap: () {
              ref.read(inputModeSelectionProvider.notifier).setCamera();
              HapticFeedback.selectionClick();

              // Show coming soon message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Camera translation coming soon'),
                  backgroundColor: AppColors.info,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: AnimatedContainer(
          duration: AppTheme.durationFast,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: AppTheme.iconSizeMd,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}