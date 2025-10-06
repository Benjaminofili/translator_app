import 'package:flutter/material.dart';
import '../../../../core/utils/onboarding_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_colors.dart';

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
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.translate_rounded,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppTheme.spacingXl),
          Text(
            "Choose Your Languages",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            "Select the languages you want to translate between",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),

          DropdownButtonFormField<String>(
            value: fromLang,
            decoration: const InputDecoration(
              labelText: "Translate From",
              prefixIcon: Icon(Icons.language),
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
          const SizedBox(height: AppTheme.spacingMd),

          IconButton(
            onPressed: () async {
              setState(() {
                final temp = fromLang;
                fromLang = toLang;
                toLang = temp;
              });
              await OnboardingService.saveLanguageSelection(fromLang, toLang);
            },
            icon: Icon(
              Icons.swap_vert,
              size: AppTheme.iconSizeLg,
            ),
            color: AppColors.primary,
          ),
          const SizedBox(height: AppTheme.spacingMd),

          DropdownButtonFormField<String>(
            value: toLang,
            decoration: const InputDecoration(
              labelText: "Translate To",
              prefixIcon: Icon(Icons.translate),
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