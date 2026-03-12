import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Language notifier to manage app language
class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('bn')) {
    // Default to Bangla
    _loadLanguage();
  }

  static const String _languageKey = 'app_language';

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'bn'; // Default to Bangla
    state = Locale(languageCode);
  }

  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    state = Locale(languageCode);
  }

  Future<void> toggleLanguage() async {
    final newLanguage = state.languageCode == 'en' ? 'bn' : 'en';
    await changeLanguage(newLanguage);
  }
}

// Provider for language management
final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});
