import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/changeColorProvider.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/components/object_flat_container.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/texnik_object.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class ObjectSecurity extends StatelessWidget {
  const ObjectSecurity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppDataProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkTheme
          ? AppColors.darkBackgroundColor
          : AppColors.lightBackgroundColor,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(
              title: 'Obyektingizni qo\'riqlovga topshiring',
            ),
            SizedBox(
              height: 25,
            ),
            CustomScreenWithImage(
                image: 'assets/images/texnik_test2.png',
                text: 'Texnik qo\'riqlash markazlari orqali qo\'riqlash',
                route: TexnikObject()),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
