import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({required this.scaffoldKey});

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppDataProvider>(context);
    return AppBar(
      surfaceTintColor: Colors.white,
      flexibleSpace: const MiniRedAppBar(),
      automaticallyImplyLeading: false, // Prevents back button from appearing
      backgroundColor: Colors.white, // Change to match your color scheme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      title: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
          color: AppColors.uxuiColor,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.grey),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Qidirish',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.red),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.language, color: Colors.green),
              onPressed: () {
                // Your language button action
              },
            ),
            IconButton(
              icon: Icon(Icons.nightlight_round, color: Colors.blue),
              onPressed: () {
                themeProvider.toggleTheme();
                // Your dark mode button action
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.red),
              onPressed: () {
                // Your profile button action
              },
            ),
          ],
        ),
      ),
      centerTitle: true,
      elevation: 10,
    );
  }
}
