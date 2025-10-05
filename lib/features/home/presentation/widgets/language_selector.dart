import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String fromLang = "English";
  String toLang = "Spanish";

  final List<String> languages = ["English", "Spanish", "French", "German"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Choose your default languages",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          // From Language
          DropdownButtonFormField<String>(
            value: fromLang,
            items: languages
                .map((lang) => DropdownMenuItem(
              value: lang,
              child: Text(lang),
            ))
                .toList(),
            onChanged: (val) => setState(() => fromLang = val!),
            decoration: const InputDecoration(labelText: "Translate From"),
          ),
          const SizedBox(height: 20),

          // To Language
          DropdownButtonFormField<String>(
            value: toLang,
            items: languages
                .map((lang) => DropdownMenuItem(
              value: lang,
              child: Text(lang),
            ))
                .toList(),
            onChanged: (val) => setState(() => toLang = val!),
            decoration: const InputDecoration(labelText: "Translate To"),
          ),
        ],
      ),
    );
  }
}
