import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'dart:convert';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class AppDataProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  Timer? _statusFetchTimer;
  int _userStatus = 0;

  AppDataProvider() {
    _startFetchingUserStatus();
  }

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

  int get userStatus => _userStatus;

  void updateUserStatus(int status) {
    _userStatus = status;
    notifyListeners();
  }

  void _startFetchingUserStatus() {
    // Initialize timer to fetch user status every 30 seconds
    _statusFetchTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _fetchUserStatus();
    });

    // Fetch immediately on initialization
    _fetchUserStatus();
  }

  Future<void> _fetchUserStatus() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse('${AppConfig.serverAddress}/api/v1/user/status'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        print(userStatus);
        print(response.statusCode);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body)['data'];
          updateUserStatus(data['user_status']);
        } else {
          print('Failed to fetch user status: ${response.body}');
          // Handle login navigation or token refresh if needed
        }
      } catch (e) {
        print('Error occurred while fetching user status: $e');
        // Handle errors appropriately
      }
    } else {
      print('Token is null');
      // Handle login navigation if needed
    }
  }
}
