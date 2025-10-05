import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/section_header.dart';
import '../widgets/appearance_section.dart';
import '../widgets/audio_section.dart';
import '../widgets/languages_section.dart';
import '../widgets/about_section.dart';
import '../../../../core/theme/app_theme.dart';

/// Settings Screen
///
/// Manages app preferences:
/// - Theme (Dark/Light mode)
/// - Audio settings (TTS voice, speed)
/// - Language models
/// - About information
///
/// Path: lib/features/settings/presentation/screens/settings_screen.dart
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        children: [
          // Appearance Section
          const SectionHeader(title: 'Appearance'),
          const SizedBox(height: AppTheme.spacingSm),
          const AppearanceSection(),

          const SizedBox(height: AppTheme.spacingLg),

          // Audio Section
          const SectionHeader(title: 'Audio Preferences'),
          const SizedBox(height: AppTheme.spacingSm),
          const AudioSection(),

          const SizedBox(height: AppTheme.spacingLg),

          // Languages Section
          const SectionHeader(title: 'Languages'),
          const SizedBox(height: AppTheme.spacingSm),
          const LanguagesSection(),

          const SizedBox(height: AppTheme.spacingLg),

          // About Section
          const SectionHeader(title: 'About'),
          const SizedBox(height: AppTheme.spacingSm),
          const AboutSection(),

          const SizedBox(height: AppTheme.spacingXl),
        ],
      ),
    );
  }
}