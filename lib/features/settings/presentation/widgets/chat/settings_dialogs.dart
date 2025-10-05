import 'package:flutter/material.dart';

Future<void> showAboutDialogCustom(BuildContext context) async {
  showAboutDialog(
    context: context,
    applicationName: 'AI Translator',
    applicationVersion: '1.0.0',
    applicationLegalese: '© 2025 Your Company. All rights reserved.',
    children: const [
      Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: Text(
          'AI-powered translation assistant that supports voice, text, and camera input modes.',
        ),
      ),
    ],
  );
}

Future<bool?> showConfirmClearDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Clear Translation History?'),
      content: const Text(
        'This action will remove all saved translations. You can’t undo this.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Clear'),
        ),
      ],
    ),
  );
}
