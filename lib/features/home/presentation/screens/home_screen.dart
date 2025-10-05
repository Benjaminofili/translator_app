import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/recording_provider.dart';
import '../providers/language_provider.dart';
import '../providers/input_mode_provider.dart';
import '../widgets/language_selector_header.dart';
import '../widgets/translation_dual_field.dart';
import '../widgets/translation_actions.dart';
import '../widgets/input_mode_selector.dart';
import '../widgets/recording_button.dart';
import '../widgets/waveform_visualizer.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingProvider);
    final inputMode = ref.watch(inputModeSelectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'History',
            onPressed: () {
              context.push('/history');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Settings',
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Language Selector Header
          const LanguageSelectorHeader(),

          // Main Translation Area (scrollable)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
              child: Column(
                children: [
                  // Dual Field Layout (Source/Target)
                  const TranslationDualField(),

                  const SizedBox(height: AppTheme.spacingSm),

                  // Translation Actions (Copy/Share/Listen)
                  const TranslationActions(),
                ],
              ),
            ),
          ),

          // Bottom Section: Waveform → Button → Input Selector
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Waveform (shows when recording in voice mode)
                  if (inputMode.isVoice && recordingState.isRecording)
                    const WaveformVisualizer(),

                  const SizedBox(height: AppTheme.spacingMd),

                  // Main Action Button (Voice or Text based on mode)
                  if (inputMode.isVoice)
                    const RecordingButton()
                  else if (inputMode.isText)
                    _buildTextInputButton(context, ref)
                  else
                    _buildCameraButton(context),

                  const SizedBox(height: AppTheme.spacingLg),

                  // Input Mode Selector (Voice/Text/Camera) - Always at bottom
                  const InputModeSelector(),

                  const SizedBox(height: AppTheme.spacingMd),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputButton(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {
                _showTextInputDialog(context, ref);
              },
              icon: const Icon(Icons.keyboard_rounded),
              label: const Text('Type to translate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Tap to enter text',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Camera translation coming soon')),
                );
              },
              icon: const Icon(Icons.camera_alt_rounded),
              label: const Text('Scan to translate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cameraActive,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Point camera at text',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showTextInputDialog(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final recordingNotifier = ref.read(recordingProvider.notifier);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Enter Text',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: TextField(
          controller: textController,
          maxLines: 5,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Type your text here...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                recordingNotifier.setTranscription(textController.text.trim());
                recordingNotifier.setTranslation(
                  'Translation: ${textController.text.trim()}',
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Translate'),
          ),
        ],
      ),
    );
  }
}