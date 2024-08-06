import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'dart:convert';

class AppDataProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  Timer? _statusFetchTimer;

  // Cleanup to avoid memory leaks
  @override
  void dispose() {
    _statusFetchTimer?.cancel();
    super.dispose();
  }

  bool get isDarkTheme => _isDarkTheme;

  ThemeData get currentTheme => _isDarkTheme ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackgroundColor,
        primaryColor: AppColors.lightHeaderColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.lightTextColor),
          bodyMedium: TextStyle(color: AppColors.lightTextColor),
        ),
        dividerColor: AppColors.lightDividerColor,
        iconTheme: const IconThemeData(color: AppColors.lightIconColor),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackgroundColor,
        primaryColor: AppColors.darkHeaderColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.darkTextColor),
          bodyMedium: TextStyle(color: AppColors.darkTextColor),
        ),
        dividerColor: AppColors.darkDividerColor,
        iconTheme: const IconThemeData(color: AppColors.darkIconColor),
      );

  Map<String, TimeOfDay> startTimes = {};
  Map<String, TimeOfDay> endTimes = {};

  void updateStartTime(String label, TimeOfDay time) {
    startTimes[label] = time;
    notifyListeners();
  }

  void updateEndTime(String label, TimeOfDay time) {
    endTimes[label] = time;
    notifyListeners();
  }

  Locale _locale = Locale('uzlat');
  Map<String, String> _localizedStrings = {};

  Locale get locale => _locale;
  Map<String, String> get localizedStrings => _localizedStrings;

  AppDataProvider() {
    loadLanguage(_locale.languageCode); // Load default language on init
  }

  Future<void> loadLanguage(String languageCode) async {
    _locale = Locale(languageCode);

    try {
      // Load the JSON string from assets
      String jsonString =
          await rootBundle.loadString('assets/translations/$languageCode.json');
      // Decode the JSON string into a Map
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // Properly cast the map to Map<String, String>
      _localizedStrings = {};
      for (var item in jsonMap['data']) {
        item.forEach((key, value) {
          _localizedStrings[key as String] = value as String;
        });
      }

      notifyListeners();
    } catch (e) {
      print('Error loading language: $e');
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
