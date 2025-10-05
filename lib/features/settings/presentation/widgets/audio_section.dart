import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Audio Section Widget
///
/// Manages TTS (Text-to-Speech) voice selection and speed settings.
class AudioSection extends StatefulWidget {
  const AudioSection({super.key});

  @override
  State<AudioSection> createState() => _AudioSectionState();
}

class _AudioSectionState extends State<AudioSection> {
  double _ttsSpeed = 1.0;
  String _ttsVoice = 'Neural';

  void _showVoicePicker() {
    final voices = ['Neural', 'Natural', 'Standard', 'Wavenet'];

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
              'Select TTS Voice',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppTheme.spacingMd),
            ...voices.map((voice) {
              final isSelected = voice == _ttsVoice;
              return ListTile(
                title: Text(voice),
                trailing: isSelected
                    ? Icon(Icons.check_circle, color: AppColors.success)
                    : null,
                selected: isSelected,
                selectedTileColor: AppColors.primaryContainer.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                onTap: () {
                  setState(() => _ttsVoice = voice);
                  Navigator.pop(context);
                },
              );
            }),
            const SizedBox(height: AppTheme.spacingSm),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.record_voice_over_rounded,
              color: AppColors.primary,
            ),
            title: const Text('TTS Voice'),
            subtitle: Text(_ttsVoice),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _showVoicePicker(),
          ),
          const Divider(height: 1, indent: 72),
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.speed_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Text(
                      'Speech Speed',
                      style: theme.textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Text(
                        '${_ttsSpeed.toStringAsFixed(1)}x',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Slider(
                  value: _ttsSpeed,
                  min: 0.5,
                  max: 2.0,
                  divisions: 15,
                  label: '${_ttsSpeed.toStringAsFixed(1)}x',
                  onChanged: (value) {
                    setState(() => _ttsSpeed = value);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0.5x',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '2.0x',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}