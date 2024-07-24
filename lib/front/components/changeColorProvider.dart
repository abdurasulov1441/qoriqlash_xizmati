import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/back/hive/favorite_model.dart';
import 'package:qoriqlash_xizmati/back/hive/hive_box.dart';
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

  String _imagePath = 'assets/images/step1.svg';

  String get imagePath => _imagePath;

  void changeImage() {
    _imagePath = _imagePath == 'assets/images/step1.svg'
        ? 'assets/images/step2.svg'
        : 'assets/images/step2.svg';
    notifyListeners();
  }

  Future<void> onCheck(int index, List<UsersModel> allNotes) async {
    await HiveBox.favotiresBox.putAt(
        index,
        UsersModel(
          userAuth: true,
        ));
  }
}
