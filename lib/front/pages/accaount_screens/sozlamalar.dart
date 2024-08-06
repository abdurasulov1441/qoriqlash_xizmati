import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';

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
                allprovider.translate('settings'), // Use the translate method
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.brightness_4),
                onPressed: () {
                  allprovider.toggleTheme();
                },
              ),
              LanguageToggleButton(
                languages: languages,
                languageImages: languageImages,
                onLanguageChanged: (language) {
                  allprovider.loadLanguage(language);
                },
              ),
            ],
          ),
          Text(
            allprovider.translate('settings'),
            style: TextStyle(fontSize: 24),
          ),
          Text(
            allprovider.translate('language'),
            style: TextStyle(fontSize: 24),
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
