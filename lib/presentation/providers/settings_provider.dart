import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String _locale = 'en';
  bool _voiceOutputEnabled = true;
  bool _isOfflineMode = false;
  bool _isInitialized = false;

  String get locale => _locale;
  bool get voiceOutputEnabled => _voiceOutputEnabled;
  bool get isOfflineMode => _isOfflineMode;
  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    _locale = prefs.getString('locale') ?? 'en';
    _voiceOutputEnabled = prefs.getBool('voiceOutput') ?? true;
    _isOfflineMode = prefs.getBool('offlineMode') ?? false;

    _isInitialized = true;
    notifyListeners();
  }

  Future<void> setLocale(String locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
    notifyListeners();
  }

  Future<void> setVoiceOutputEnabled(bool enabled) async {
    _voiceOutputEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('voiceOutput', enabled);
    notifyListeners();
  }

  Future<void> setOfflineMode(bool enabled) async {
    _isOfflineMode = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('offlineMode', enabled);
    notifyListeners();
  }

  Future<void> speak(String text) async {
    debugPrint('TTS: $text');
  }

  Future<void> stopSpeaking() async {}
}
