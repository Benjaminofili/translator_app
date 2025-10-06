import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_colors.dart';

class PermissionCard extends StatefulWidget {
  const PermissionCard({super.key});

  @override
  State<PermissionCard> createState() => _PermissionCardState();
}

class _PermissionCardState extends State<PermissionCard> with AutomaticKeepAliveClientMixin {
  bool granted = false;
  bool _isChecking = true;
  bool _hasRequestedOnce = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _autoRequestPermission();
      }
    });
  }

  Future<void> _autoRequestPermission() async {
    if (_hasRequestedOnce) return;

    setState(() => _isChecking = true);
    _hasRequestedOnce = true;

    var status = await Permission.microphone.status;

    if (status.isGranted) {
      setState(() {
        granted = true;
        _isChecking = false;
      });
      return;
    }

    status = await Permission.microphone.request();

    if (mounted) {
      setState(() {
        granted = status.isGranted;
        _isChecking = false;
      });
    }
  }

  Future<void> _requestPermission() async {
    setState(() => _isChecking = true);

    final status = await Permission.microphone.request();

    if (status.isGranted) {
      setState(() => granted = true);
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
    }

    setState(() => _isChecking = false);
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Permission Required',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Microphone permission is required for voice translation. '
              'Please enable it in settings.',
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
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Center(
      child: Card(
        margin: const EdgeInsets.all(AppTheme.spacingLg),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isChecking)
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: AppTheme.spacingMd),
                    Text(
                      'Requesting microphone permission...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                )
              else ...[
                Icon(
                  granted ? Icons.check_circle : Icons.mic_off,
                  size: 80,
                  color: granted ? AppColors.success : AppColors.warning,
                ),
                const SizedBox(height: AppTheme.spacingMd),
                Text(
                  granted
                      ? "Permission Granted!"
                      : "Microphone Permission Needed",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  granted
                      ? "You're ready to use voice translation."
                      : "We need microphone access to translate your voice in real-time.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),
                if (!granted)
                  ElevatedButton.icon(
                    onPressed: _requestPermission,
                    icon: const Icon(Icons.mic),
                    label: const Text("Grant Permission"),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}