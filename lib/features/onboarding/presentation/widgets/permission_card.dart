import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
    // Small delay to ensure widget is fully mounted
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

    // Auto-request on first time
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
        title: const Text('Permission Required'),
        content: const Text(
          'Microphone permission is required for voice translation. '
              'Please enable it in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
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
        margin: const EdgeInsets.all(24),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isChecking)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Requesting microphone permission...',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                )
              else ...[
                Icon(
                  granted ? Icons.check_circle : Icons.mic_off,
                  size: 80,
                  color: granted ? Colors.green : Colors.orange,
                ),
                const SizedBox(height: 20),
                Text(
                  granted
                      ? "Permission Granted!"
                      : "Microphone Permission Needed",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  granted
                      ? "You're ready to use voice translation."
                      : "We need microphone access to translate your voice in real-time.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 24),
                if (!granted)
                  ElevatedButton.icon(
                    onPressed: _requestPermission,
                    icon: const Icon(Icons.mic),
                    label: const Text("Grant Permission"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}