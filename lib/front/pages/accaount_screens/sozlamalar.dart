import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/reset_password/reset_password.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/accaount_screens/yordam_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class Sozlamalar extends StatelessWidget {
  const Sozlamalar({super.key});

  @override
  Widget build(BuildContext context) {
    final allprovider = Provider.of<AppDataProvider>(context);
    final List<String> languages = ['ru', 'uzkiril', 'uzlat'];
    final List<String> languageImages = [
      'assets/images/ru.jpg',
      'assets/images/uz.png',
      'assets/images/uz.png'
    ];

    return Scaffold(
      body: Column(
        children: [
          MiniRedAppBar(),
          MiniRedTitle(
            title:
                allprovider.translate('sozlamalar'), // Use the translate method
          ),
          GestureDetector(
            onTap: () {
              allprovider.toggleTheme();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: AppColors.uxuiColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      allprovider.translate('sozlamalar2'),
                      style: AppStyle.fontStyle,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: IconButton(
                      icon: Icon(
                        Icons.brightness_4,
                        color: AppColors.lightIconGuardColor,
                      ),
                      onPressed: () {
                        allprovider.toggleTheme();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: AppColors.uxuiColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      allprovider.translate('sozlamalar1'),
                      style: AppStyle.fontStyle,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: LanguageToggleButton(
                      languages: languages,
                      languageImages: languageImages,
                      onLanguageChanged: (language) {
                        allprovider.loadLanguage(language);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FaqPage()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: AppColors.uxuiColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      allprovider.translate('sozlamalar3'),
                      style: AppStyle.fontStyle,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.arrow_right,
                      color: AppColors.lightIconGuardColor,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => XavfsizlikPage()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: AppColors.uxuiColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      allprovider.translate('sozlamalar4'),
                      style: AppStyle.fontStyle,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.lock,
                      color: AppColors.lightIconGuardColor,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageToggleButton extends StatefulWidget {
  final List<String> languages;
  final List<String> languageImages;
  final ValueChanged<String> onLanguageChanged;

  const LanguageToggleButton({
    required this.languages,
    required this.languageImages,
    required this.onLanguageChanged,
    super.key,
  });

  @override
  _LanguageToggleButtonState createState() => _LanguageToggleButtonState();
}

class _LanguageToggleButtonState extends State<LanguageToggleButton> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        widget.languageImages[currentIndex],
        width: 40,
        height: 40,
      ),
      onPressed: () {
        setState(() {
          currentIndex = (currentIndex + 1) % widget.languages.length;
        });
        widget.onLanguageChanged(widget.languages[currentIndex]);
      },
    );
  }
}
