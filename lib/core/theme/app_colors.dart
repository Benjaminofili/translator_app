import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6750A4);
  static const Color primaryLight = Color(0xFF9A82DB);
  static const Color primaryDark = Color(0xFF381E72);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);

  // Secondary Colors
  static const Color secondary = Color(0xFF625B71);
  static const Color secondaryLight = Color(0xFF8B839A);
  static const Color secondaryDark = Color(0xFF3A344A);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color onSecondaryContainer = Color(0xFF1D192B);

  // Tertiary Colors (Accent)
  static const Color tertiary = Color(0xFF7D5260);
  static const Color tertiaryContainer = Color(0xFFFFD8E4);
  static const Color onTertiaryContainer = Color(0xFF31111D);

  // Surface Colors
  static const Color surface = Color(0xFFFCFBFF);
  static const Color surfaceDim = Color(0xFFF4F3F7);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF7F5FA);
  static const Color surfaceContainer = Color(0xFFF3F1F6);
  static const Color surfaceContainerHigh = Color(0xFFECEAEF);
  static const Color surfaceContainerHighest = Color(0xFFE6E4E9);

  // Background Colors
  static const Color background = Color(0xFFFCFBFF);
  static const Color onBackground = Color(0xFF1C1B1F);

  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF410002);

  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF80E27E);
  static const Color successDark = Color(0xFF087F23);
  static const Color onSuccess = Color(0xFFFFFFFF);

  // Warning Colors
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFCC80);
  static const Color warningDark = Color(0xFFF57C00);
  static const Color onWarning = Color(0xFF000000);

  // Info Colors
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF6EC6FF);
  static const Color infoDark = Color(0xFF0069C0);
  static const Color onInfo = Color(0xFFFFFFFF);

  // Outline Colors
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFCAC4D0);

  // Shadow Colors
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  // Inverse Colors
  static const Color inverseSurface = Color(0xFF313033);
  static const Color inverseOnSurface = Color(0xFFF4EFF4);
  static const Color inversePrimary = Color(0xFFD0BCFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1C1B1F);
  static const Color textSecondary = Color(0xFF49454F);
  static const Color textTertiary = Color(0xFF79747E);
  static const Color textDisabled = Color(0xFFCAC4D0);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Input Colors
  static const Color inputBackground = Color(0xFFF7F5FA);
  static const Color inputBorder = Color(0xFFE8E6EC);
  static const Color inputBorderFocused = Color(0xFF6750A4);
  static const Color inputHint = Color(0xFF79747E);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFFD0BCFF);
  static const Color darkPrimaryContainer = Color(0xFF4F378B);
  static const Color darkOnPrimaryContainer = Color(0xFFEADDFF);

  static const Color darkSecondary = Color(0xFFCCC2DC);
  static const Color darkSecondaryContainer = Color(0xFF4A4458);
  static const Color darkOnSecondaryContainer = Color(0xFFE8DEF8);

  static const Color darkSurface = Color(0xFF1C1B1F);
  static const Color darkSurfaceContainer = Color(0xFF201F23);
  static const Color darkSurfaceContainerHigh = Color(0xFF2B2930);
  static const Color darkSurfaceContainerHighest = Color(0xFF36343B);

  static const Color darkBackground = Color(0xFF1C1B1F);
  static const Color darkOnBackground = Color(0xFFE6E1E5);

  static const Color darkOutline = Color(0xFF938F99);
  static const Color darkOutlineVariant = Color(0xFF49454F);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [surfaceContainerLow, surface],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkPrimary, darkSecondary],
  );

  // Semantic Colors for Translation States
  static const Color sourceLanguage = primary;
  static const Color targetLanguage = secondary;
  static const Color translating = info;
  static const Color translated = success;
  static const Color translationError = error;

  // Special Purpose Colors
  static const Color voiceRecording = Color(0xFFE91E63);
  static const Color voiceRecordingActive = Color(0xFFFF5252);
  static const Color cameraActive = Color(0xFF00BCD4);
  static const Color offlineMode = warning;

  // Tone Indicator Colors (for formal/informal translations)
  static const Color toneFormal = Color(0xFF1565C0);
  static const Color toneNeutral = Color(0xFF757575);
  static const Color toneCasual = Color(0xFF7CB342);
}