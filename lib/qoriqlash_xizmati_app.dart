import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/login_page/login_page.dart';
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';
import 'package:qoriqlash_xizmati/front/components/changeColorProvider.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn;

    return ValueListenableBuilder(
        valueListenable: Hive.box<NotesData>('notes').listenable(),
        builder: (context, Box<NotesData> box, _) {
          final box = Hive.box<NotesData>('notes');
          if (box.isNotEmpty) {
            String? token = box.getAt(0)?.userToken;
            print(token);
            isLoggedIn = true;
          } else {
            print('data in hive not found aniqrogi bom bosh');
            isLoggedIn = false;
          }

          return FlutterSplashScreen.fadeIn(
            backgroundColor: Colors.white,
            duration: const Duration(seconds: 3),
            childWidget: const SplashScreenContent(),
            nextScreen: isLoggedIn ? HomePage() : LoginScreen(),
          );
        });
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
          // RichText(
          //     text: const TextSpan(
          //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          //   children: <TextSpan>[
          //     TextSpan(
          //         text: 'Qo\'riqlash',
          //         style: TextStyle(color: AppColors.lightTextColor)),
          //     TextSpan(
          //         text: 'Xizmati',
          //         style: TextStyle(color: AppColors.lightTextColor)),
          //   ],
          // )),
        ],
      ),
    );
  }
}
