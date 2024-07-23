import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/changeColorProvider.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:provider/provider.dart';

class QoriqlashXizmatiApp extends StatelessWidget {
  const QoriqlashXizmatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppDataProvider()),
      ],
      child: Consumer<AppDataProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.currentTheme,
            routes: {
              '/': (context) => const SplashScreenWidget(),
            },
            initialRoute: '/',
          );
        },
      ),
    );
  }
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
      childWidget: const SplashScreenContent(),
      nextScreen: HomePage(),
    );
  }
}

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/set.png',
            width: 200,
            height: 200,
          ),
          RichText(
              text: const TextSpan(
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(text: 'Xavfsiz', style: TextStyle(color: Colors.white)),
              TextSpan(text: 'Turizm'),
            ],
          )),
        ],
      ),
    );
  }
}
