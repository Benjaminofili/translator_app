import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/recording_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class WaveformVisualizer extends ConsumerWidget {
  const WaveformVisualizer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingProvider);

    if (!recordingState.isRecording || recordingState.waveformAmplitudes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLg,
        vertical: AppTheme.spacingSm,
      ),
      padding: const EdgeInsets.all(AppTheme.spacingSm),
      decoration: BoxDecoration(
        color: AppColors.voiceRecording.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: CustomPaint(
        painter: WaveformPainter(
          amplitudes: recordingState.waveformAmplitudes,
          color: AppColors.voiceRecording,
        ),
        size: const Size(double.infinity, 80),
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final Color color;

  WaveformPainter({
    required this.amplitudes,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (amplitudes.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final barWidth = size.width / amplitudes.length;
    final centerY = size.height / 2;

    for (int i = 0; i < amplitudes.length; i++) {
      final x = i * barWidth + barWidth / 2;
      final amplitude = amplitudes[i];
      final barHeight = amplitude * size.height * 0.8;

      // Draw from center outward
      canvas.drawLine(
        Offset(x, centerY - barHeight / 2),
        Offset(x, centerY + barHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return true; // Always repaint for smooth animation
  }
}