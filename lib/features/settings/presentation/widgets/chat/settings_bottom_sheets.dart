import 'package:flutter/material.dart';

Future<String?> showVoiceSelectionSheet(BuildContext context) async {
  final List<String> voices = ['Female (Default)', 'Male', 'Robot', 'Child'];
  String selected = 'Female (Default)';

  final result = await showModalBottomSheet<String>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text(
            'Select Voice',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          for (final voice in voices)
            RadioListTile<String>(
              value: voice,
              groupValue: selected,
              title: Text(voice),
              onChanged: (val) {
                Navigator.pop(ctx, val); // ✅ Return the selected voice
              },
            ),
        ],
      ),
    ),
  );

  return result; // ✅ Return the selection to the caller
}

