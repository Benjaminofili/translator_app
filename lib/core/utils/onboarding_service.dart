import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _keySeenOnboarding = 'seenOnboarding';
  static const _keySelectedFromLang = 'selectedFromLang';
  static const _keySelectedToLang = 'selectedToLang';

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keySeenOnboarding) ?? false;
  }

  static Future<void> setSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySeenOnboarding, true);
  }

  static Future<void> saveLanguageSelection(String fromLang, String toLang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySelectedFromLang, fromLang);
    await prefs.setString(_keySelectedToLang, toLang);
  }

  static Future<Map<String, String>> getLanguageSelection() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'from': prefs.getString(_keySelectedFromLang) ?? 'English',
      'to': prefs.getString(_keySelectedToLang) ?? 'Spanish',
    };
  }
}