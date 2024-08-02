import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/login_page/login_page.dart';
import 'package:qoriqlash_xizmati/front/pages/account_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page/home_page_elements.dart';
import 'package:qoriqlash_xizmati/front/pages/news_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screen.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? _child;
  int userStatus = 0;

  @override
  void initState() {
    super.initState();
    _child = const HomePageElements();
    _fetchUserStatus();
  }

  Future<void> _fetchUserStatus() async {
    final box = Hive.box<NotesData>('notes');
    if (box.isNotEmpty) {
      String? token = box.getAt(0)?.userToken;
      if (token != null) {
        try {
          final response = await http.get(
            Uri.parse('http://10.100.9.145:7684/api/v1/user/status'),
            headers: {
              'Authorization': 'Bearer $token',
            },
          );

          if (response.statusCode == 200) {
            final Map<String, dynamic> data = json.decode(response.body);
            if (data['status'] == 200) {
              int status = data['data']['user_status'];
              print('User status: $status');
              setState(() {
                userStatus = status;
              });
              // Save user status to Hive
              box.putAt(0, NotesData()..userToken = token);
            } else {
              print('User status fetch failed: ${data['data']['user_status']}');
              setState(() {
                userStatus = 0;
              });
              _redirectToLogin();
            }
          } else if (response.statusCode == 400) {
            print('Failed to fetch user status: ${response.statusCode}');
            setState(() {
              userStatus = 0;
            });
            _clearLocalStorage();
            _redirectToLogin();
          }
        } catch (e) {
          print('Error fetching user status: $e');
        }
      }
    }
  }

  void _clearLocalStorage() {
    final box = Hive.box<NotesData>('notes');
    box.deleteAt(0); // Clear the stored token
  }

  void _redirectToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    ); // Redirect to login page
  }

  List<FluidNavBarIcon> _buildIcons() {
    return [
      FluidNavBarIcon(
        icon: Icons.home,
        backgroundColor: AppColors.lightIconGuardColor,
        extras: {"label": "Sahifa"},
      ),
      FluidNavBarIcon(
        icon: Icons.newspaper,
        backgroundColor: AppColors.lightIconGuardColor,
        extras: {"label": "Yangiliklar"},
      ),
      FluidNavBarIcon(
        icon: Icons.book,
        backgroundColor: AppColors.lightIconGuardColor,
        extras: {"label": "Tariflar"},
      ),
      FluidNavBarIcon(
        icon: Icons.person,
        backgroundColor: AppColors.lightIconGuardColor,
        extras: {"label": "Kabinet"},
      ),
    ];
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const HomePageElements();
          break;
        case 1:
          _child = NewsPage();
          break;
        case 2:
          _child = const SendRequestSafingScreen();
          break;
        case 3:
          _child = userStatus == 1
              ? const AccountScreenNotLogin()
              : (userStatus == 2 ? const AccountScreen() : LoginScreen());
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
        child: _child,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<NotesData>('notes');
    if (box.isNotEmpty) {
      String? token = box.getAt(0)?.userToken;
      print(token);
    } else {
      print('data in hive not found aniqrogi bom bosh');
    }

    return Scaffold(
      body: Container(child: _child),
      bottomNavigationBar: SafeArea(
        child: FluidNavBar(
          animationFactor: 0.5,
          icons: _buildIcons(),
          onChange: (index) => _handleNavigationChange(index),
          style: const FluidNavBarStyle(
            barBackgroundColor: AppColors.lightIconGuardColor,
            iconSelectedForegroundColor: Colors.white,
            iconUnselectedForegroundColor: Colors.white,
          ),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }
}
