import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/login_page/login_page.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/reset_password/reset_password.dart';
import 'package:qoriqlash_xizmati/front/components/appbar_title.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/front/pages/accaount_screens/shartnomalar.dart';
import 'package:qoriqlash_xizmati/front/pages/accaount_screens/shaxsiy_malumotlar.dart';
import 'package:qoriqlash_xizmati/front/pages/accaount_screens/verification_page.dart';
import 'package:qoriqlash_xizmati/front/pages/accaount_screens/visacard.dart';
import 'package:qoriqlash_xizmati/front/pages/accaount_screens/yordam_page.dart';
import 'package:qoriqlash_xizmati/front/pages/pult_boshligi_pages/pult_boshligi_home.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String fullName = ''; //'Raximov Voris Avazbek o\'g\'li'; // Default name

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chiqish'),
          content: const Text('Haqiqatdan ham chiqmoqchimisiz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Yo\'q'),
            ),
            TextButton(
              onPressed: () async {
                // Create an instance of FlutterSecureStorage
                final storage = FlutterSecureStorage();

                // Clear the tokens
                await storage.delete(key: 'accessToken');
                await storage.delete(key: 'refreshToken');

                // Navigate to LoginScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Chiqish'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchUserData() async {
    // Create an instance of FlutterSecureStorage
    final storage = FlutterSecureStorage();

    // Retrieve the token
    final token = await storage.read(key: 'accessToken');

    if (token != null) {
      final response = await http.get(
        Uri.parse('${AppConfig.serverAddress}/api/v1/user/info'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      print(response.body);
      print(token);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          fullName =
              '${data['first_name']} ${data['last_name']} ${data['surname']}';
        });
      } else {
        // Handle error
        print('Failed to fetch user data in account screen');
      }
    } else {
      // Handle the case where token is not available
      print('Token not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppDataProvider>(context);
    final List<String> name = [
      'Shartnomalar',
      'Arizalar',
      'Xavfsizlik',
      'Shaxsiy ma\'lumotlar',
      'Mening kartalarim',
      'Yordam',
      'Qorong\'u rejim',
      'Chiqish',
    ];
    final List<String> image = [
      'shartnoma.svg',
      'arizalar.svg',
      'havfsizlik.svg',
      'shaxsiy_malumotlar.svg',
      'mening_kartalarim.svg',
      'yordam.svg',
      'tungi_rejim.svg',
      'logout.svg',
    ];
    final List<Widget> route = [
      Shartnomalar(),
      Shartnomalar(),
      XavfsizlikPage(),
      ShaxsiyMalumotlar(),
      Cards(),
      FaqPage(),
      Divider(),
      Shartnomalar(),
    ];
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const AppbarTitle(),
            const CircleAvatar(
              backgroundColor: AppColors.lightBackgroundColor,
              radius: 50,
              backgroundImage: AssetImage('assets/images/person.png'),
            ),
            Text(
              fullName,
              style: AppStyle.fontStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkTheme
                    ? AppColors.darkTextColor
                    : AppColors.lightTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/house.png',
                  width: 60,
                  height: 60,
                ),
                Column(
                  children: [
                    Text(
                      'Mening uyim',
                      style: AppStyle.fontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkTheme
                            ? AppColors.darkTextColor
                            : AppColors.lightTextColor,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_upward,
                          color: Colors.greenAccent,
                        ),
                        Text(
                          '+230 154 so\'m',
                          style: AppStyle.fontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: themeProvider.isDarkTheme
                                ? AppColors.darkTextColor
                                : AppColors.lightTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Image.asset(
                  'assets/images/lock.png',
                  width: 60,
                  height: 60,
                ),
                Image.asset(
                  'assets/images/emerency_on.png',
                  width: 60,
                  height: 60,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: SvgPicture.asset(
                        'assets/images/${image[index]}',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(
                        name[index],
                        style: AppStyle.fontStyle.copyWith(
                          color: themeProvider.isDarkTheme
                              ? AppColors.darkTextColor
                              : AppColors.lightTextColor,
                        ),
                      ),
                      onTap: () {
                        if (name[index] == 'Chiqish') {
                          showLogoutDialog(context);
                        } else if (name[index] == 'Qorong\'u rejim') {
                          // Handle dark mode toggle
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => route[index],
                            ),
                          );
                        }
                      },
                      trailing: name[index] == 'Qorong\'u rejim'
                          ? CupertinoSwitch(
                              value: themeProvider.isDarkTheme,
                              onChanged: (value) {
                                themeProvider.toggleTheme();
                              },
                            )
                          : Icon(
                              Icons.keyboard_arrow_right,
                              color: themeProvider.isDarkTheme
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor,
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountScreenNotLogin extends StatefulWidget {
  const AccountScreenNotLogin({super.key});

  @override
  State<AccountScreenNotLogin> createState() => _AccountScreenNotLoginState();
}

class _AccountScreenNotLoginState extends State<AccountScreenNotLogin> {
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chiqish'),
          content: const Text('Haqiqatdan ham chiqmoqchimisiz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Yo\'q'),
            ),
            TextButton(
              onPressed: () async {
                // Create an instance of FlutterSecureStorage
                final storage = FlutterSecureStorage();

                // Clear the tokens
                await storage.delete(key: 'accessToken');
                await storage.delete(key: 'refreshToken');

                // Navigate to LoginScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Chiqish'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppDataProvider>(context);
    final List name = [
      'Yordam',
      'Qorong\'u rejim',
      'Chiqish',
      'Verifikatiyadan o\'tish',
      'Pult Boshligi',
    ];
    final List image = [
      'yordam.svg',
      'tungi_rejim.svg',
      'logout.svg',
      'logout.svg',
      'logout.svg',
    ];
    final List<Widget> route = [
      FaqPage(),
      Divider(),
      Shartnomalar(),
      FaceVirify(),
      PultBoshligiHome(),
    ];
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const AppbarTitle(),
            const CircleAvatar(
              backgroundColor: AppColors.lightBackgroundColor,
              radius: 50, // Radius of the inner circle (avatar)
              backgroundImage: AssetImage(
                  'assets/images/avatar.png'), // Image for the avatar
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Shaxsi tasdiqlanmagan foydalanuvchi',
              style: AppStyle.fontStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkTheme
                      ? AppColors.darkTextColor
                      : AppColors.lightTextColor),
            ),

            // const SizedBox(
            //   height: 10,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: SvgPicture.asset(
                          'assets/images/${image[index]}',
                          width: 30,
                          height: 30,
                        ),
                        // title: item.buildTitle(context),
                        // subtitle: item.buildSubtitle(context),
                        title: Text(
                          name[index],
                          style: AppStyle.fontStyle.copyWith(
                              color: themeProvider.isDarkTheme
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor),
                        ),
                        onTap: () {
                          print(name[index]);
                          if (name[index] == 'Chiqish') {
                            showLogoutDialog(context);
                          } else if (name[index] == 'Qorong\'u rejim') {
                            null;
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => route[index]),
                            );
                          }
                        },
                        //leading: Image.asset(images[index],width: 50,height: 50,),
                        textColor: Colors.white,
                        trailing: name[index] == 'Qorong\'u rejim'
                            ? CupertinoSwitch(
                                value: themeProvider.isDarkTheme,
                                onChanged: (value) {
                                  themeProvider.toggleTheme();
                                },
                              )
                            : Icon(
                                Icons.keyboard_arrow_right,
                                color: themeProvider.isDarkTheme
                                    ? AppColors.darkTextColor
                                    : AppColors.lightTextColor,
                                weight: 20,
                              ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
