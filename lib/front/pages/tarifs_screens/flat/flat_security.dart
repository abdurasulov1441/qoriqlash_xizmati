import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/components/object_flat_container.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/flat/texnik_flat.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class FlatSecurity extends StatelessWidget {
  const FlatSecurity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppDataProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkTheme
          ? AppColors.darkBackgroundColor
          : AppColors.lightBackgroundColor,
      body: const Column(
        children: [
          MiniRedAppBar(),
          MiniRedTitle(
            title: 'Xonadoningizni qo\'riqlovga topshiring',
          ),
          SizedBox(
            height: 20,
          ),
          CustomScreenWithImage(
              image: 'assets/images/texnik_test2.png',
              text: 'Texnik qo\'riqlash markazlari orqali qo\'riqlash',
              route: TexnikFlat()),
        ],
      ),
    );
  }
}
