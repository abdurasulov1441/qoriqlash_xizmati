import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/front/pages/account_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page/home_page_elements.dart';
import 'package:qoriqlash_xizmati/front/pages/news_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screen.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const HomePageElements(),
          item: ItemConfig(
            icon: const Icon(
              Icons.home,
              color: AppColors.lightHeaderColor,
            ),
            title: "Sahifa",
          ),
        ),
        PersistentTabConfig(
          screen: NewsPage(),
          item: ItemConfig(
            icon: const Icon(
              Icons.newspaper,
              color: AppColors.lightHeaderColor,
            ),
            title: "Yangiliklar",
          ),
        ),
        PersistentTabConfig(
          screen: const SendRequestSafingScreen(),
          item: ItemConfig(
            icon: const Icon(
              Icons.book,
              color: AppColors.lightHeaderColor,
            ),
            title: "Tariflar",
          ),
        ),
        PersistentTabConfig(
          screen: const AccountScreen(),
          item: ItemConfig(
              icon: const Icon(
                Icons.person,
                color: AppColors.lightHeaderColor,
              ),
              title: "Kabinet",
              activeColorSecondary: AppColors.lightHeaderColor),
        ),
      ];

  @override
  Widget build(BuildContext context) => PersistentTabView(
        popAllScreensOnTapAnyTabs: true,
        popActionScreens: PopActionScreensType.all,
        screenTransitionAnimation: const ScreenTransitionAnimation(
            duration: Duration(milliseconds: 300)),
        tabs: _tabs(),
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarDecoration:
              const NavBarDecoration(color: AppColors.lightIconGuardColor),
          navBarConfig: navBarConfig,
        ),
      );
}
