import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }
}
