import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsProvider extends ChangeNotifier {
  final Box _settingsBox = Hive.box('settings');

  bool get isUserActive =>
      _settingsBox.get('isUserActive', defaultValue: false);
  bool get isDarkTheme => _settingsBox.get('isDarkTheme', defaultValue: false);

  void setUserActive(bool value) {
    _settingsBox.put('isUserActive', value);
    notifyListeners();
  }

  void setDarkTheme(bool value) {
    _settingsBox.put('isDarkTheme', value);
    notifyListeners();
  }
}
