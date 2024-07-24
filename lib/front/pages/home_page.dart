import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/back/hive/favorite_model.dart';
import 'package:qoriqlash_xizmati/back/hive/hive_box.dart'; // Import HiveBox
import 'package:qoriqlash_xizmati/front/pages/account_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page/home_page_elements.dart';
import 'package:qoriqlash_xizmati/front/pages/news_screen.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screen.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<FavoriteModel?> _modelFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the user authentication state from Hive
    _modelFuture = _fetchFavoriteModel();
  }

  Future<FavoriteModel?> _fetchFavoriteModel() async {
    final box = HiveBox.favotiresBox;
    return box.get('userstate');
  }

  List<PersistentTabConfig> _tabs(bool userAuth) => [
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
          screen:
              userAuth ? const AccountScreen() : const AccountScreenNotLogin(),
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
  Widget build(BuildContext context) {
    return FutureBuilder<FavoriteModel?>(
      future: _modelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No data available'));
        }

        final bool userAuth = snapshot.data!.userAuth;
        return PersistentTabView(
          popAllScreensOnTapAnyTabs: true,
          popActionScreens: PopActionScreensType.all,
          screenTransitionAnimation: const ScreenTransitionAnimation(
              duration: Duration(milliseconds: 300)),
          tabs: _tabs(userAuth),
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarDecoration:
                const NavBarDecoration(color: AppColors.lightIconGuardColor),
            navBarConfig: navBarConfig,
          ),
        );
      },
    );
  }
}
