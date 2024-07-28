import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/account_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page/home_page_elements.dart';
import 'package:qoriqlash_xizmati/front/pages/news_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screen.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? _child;

  @override
  void initState() {
    _child = const HomePageElements();
    super.initState();
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

  void _handleNavigationChange(int index, bool isLoggedIn) {
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
          _child = isLoggedIn ? AccountScreen() : AccountScreenNotLogin();
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
    return ValueListenableBuilder(
      valueListenable: Hive.box<bool>('userBox').listenable(),
      builder: (context, Box<bool> box, _) {
        bool isLoggedIn = box.get(0, defaultValue: false) ?? false;
        return Scaffold(
          //  backgroundColor: Colors.transparent,
          // backgroundColor: const Color(0xFF75B7E1),
          // extendBody: true,
          body: Container(child: _child),
          bottomNavigationBar: SafeArea(
            child: FluidNavBar(
              icons: _buildIcons(),
              onChange: (index) => _handleNavigationChange(index, isLoggedIn),
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
      },
    );
  }
}
