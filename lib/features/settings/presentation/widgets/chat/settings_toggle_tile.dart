import 'package:flutter/material.dart';

class SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
