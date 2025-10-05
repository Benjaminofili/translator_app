import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
        ),
        title: const Text('John Doe'),
        subtitle: const Text('Premium User'),
        trailing: IconButton(
          icon: const Icon(Icons.edit_rounded),
          onPressed: () {
            // TODO: Edit profile
          },
        ),
      ),
    );
  }
}
