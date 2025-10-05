import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Later, this will show real translation history from persistence
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation History'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'No translations yet.\nYour recent translations will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
