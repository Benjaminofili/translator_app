import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionCard extends StatefulWidget {
  const PermissionCard({super.key});

  @override
  State<PermissionCard> createState() => _PermissionCardState();
}

class _PermissionCardState extends State<PermissionCard> {
  bool granted = false;

  Future<void> _requestPermission() async {
    final status = await Permission.microphone.request();

    if (status.isGranted) {
      setState(() => granted = true);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                granted ? Icons.check_circle : Icons.mic,
                size: 80,
                color: granted ? Colors.green : Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                granted
                    ? "Microphone Permission Granted"
                    : "Enable Microphone Access",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                granted
                    ? "You can now use voice translation."
                    : "We need microphone permission to let you speak and translate in real-time.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (!granted)
                ElevatedButton(
                  onPressed: _requestPermission,
                  child: const Text("Grant Permission"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
