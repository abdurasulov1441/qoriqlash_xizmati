import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/changeColorProvider.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/login_page/login_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

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

  Future<Widget> determineNextScreen() async {
    // Create an instance of FlutterSecureStorage
    final storage = FlutterSecureStorage();

    // Retrieve the token from secure storage
    String? token = await storage.read(key: 'accessToken');

    if (token != null) {
      // Token exists, return HomePage
      return HomePage();
    } else {
      // Token is null, print message and return LoginScreen
      print('Token is null');
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: determineNextScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return FlutterSplashScreen.fadeIn(
            backgroundColor: Colors.white,
            duration: const Duration(seconds: 3),
            childWidget: const SplashScreenContent(),
            nextScreen: snapshot.data!,
          );
        }
      },
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Qo\'riqlash',
                style: AppStyle.fontStyle.copyWith(fontSize: 20),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Xizmati',
                style: AppStyle.fontStyle.copyWith(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
