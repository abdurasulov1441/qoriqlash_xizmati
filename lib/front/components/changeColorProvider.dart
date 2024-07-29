import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class AppDataProvider with ChangeNotifier {
  bool _isDarkTheme = false;

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

  Future<void> onLogin(BuildContext context, String token) async {
    var box = Hive.box<NotesData>('notes');
    await box.putAt(0, NotesData(isChecked: true, userToken: token));
    notifyListeners();
  }

  Future<void> onExit(BuildContext context) async {
    var box = Hive.box<NotesData>('notes');
    await box.deleteAt(0);
    notifyListeners();
  }

  String? get userToken {
    var box = Hive.box<NotesData>('notes');
    return box.getAt(0)?.userToken;
  }

  bool get isUserLoggedIn {
    var box = Hive.box<NotesData>('notes');
    return box.getAt(0)?.isChecked ?? false;
  }
}
