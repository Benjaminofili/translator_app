import 'package:flutter/material.dart';
import '../../../../core/utils/onboarding_service.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String fromLang = "English";
  String toLang = "Spanish";

  final List<String> languages = [
    "English",
    "Spanish",
    "French",
    "German",
    "Italian",
    "Portuguese",
    "Chinese",
    "Japanese",
    "Korean",
    "Arabic",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.translate, size: 80, color: Colors.blue),
          const SizedBox(height: 30),
          const Text(
            "Choose Your Languages",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Select the languages you want to translate between",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 40),

          // From Language
          DropdownButtonFormField<String>(
            value: fromLang,
            decoration: InputDecoration(
              labelText: "Translate From",
              prefixIcon: const Icon(Icons.language),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: languages
                .map((lang) => DropdownMenuItem(
              value: lang,
              child: Text(lang),
            ))
                .toList(),
            onChanged: (val) async {
              setState(() => fromLang = val!);
              await OnboardingService.saveLanguageSelection(fromLang, toLang);
            },
          ),
          const SizedBox(height: 20),

          // Swap Button
          IconButton(
            onPressed: () async {
              setState(() {
                final temp = fromLang;
                fromLang = toLang;
                toLang = temp;
              });
              await OnboardingService.saveLanguageSelection(fromLang, toLang);
            },
            icon: const Icon(Icons.swap_vert, size: 32),
            color: Colors.blue,
          ),
          const SizedBox(height: 20),

          // To Language
          DropdownButtonFormField<String>(
            value: toLang,
            decoration: InputDecoration(
              labelText: "Translate To",
              prefixIcon: const Icon(Icons.translate),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: languages
                .map((lang) => DropdownMenuItem(
              value: lang,
              child: Text(lang),
            ))
                .toList(),
            onChanged: (val) async {
              setState(() => toLang = val!);
              await OnboardingService.saveLanguageSelection(fromLang, toLang);
            },
          ),
        ],
      ),
    );
  }
}