import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/recording_provider.dart';
import '../../../../core/utils/permission_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class RecordingButton extends ConsumerWidget {
  const RecordingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingProvider);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _handleTap(context, ref, recordingState.isRecording),
            child: AnimatedContainer(
              duration: AppTheme.durationMedium,
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: recordingState.isRecording
                    ? AppColors.voiceRecordingActive
                    : AppColors.voiceRecording,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (recordingState.isRecording
                        ? AppColors.voiceRecordingActive
                        : AppColors.voiceRecording)
                        .withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: recordingState.isRecording ? 8 : 5,
                  ),
                ],
              ),
              child: Icon(
                recordingState.isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
                size: AppTheme.iconSizeLg + 4,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            recordingState.isRecording ? 'Listening...' : 'Tap to speak',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleTap(
      BuildContext context,
      WidgetRef ref,
      bool isCurrentlyRecording,
      ) async {
    if (!isCurrentlyRecording) {
      final hasPermission = await PermissionService.checkMicrophonePermission();

      if (!hasPermission && context.mounted) {
        _showPermissionDialog(context);
        return;
      }

      ref.read(recordingProvider.notifier).startRecording();
    } else {
      ref.read(recordingProvider.notifier).stopRecording();
    }
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Microphone Permission Required',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Please grant microphone permission in settings to use voice translation.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              PermissionService.openSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}