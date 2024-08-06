import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'package:qoriqlash_xizmati/back/snack_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';
import 'package:http/http.dart' as http;

class SignUpSuccessPage extends StatefulWidget {
  const SignUpSuccessPage(
      {super.key, required this.phone, required this.password});

  final String phone;
  final String password;

  @override
  _SignUpSuccessPageState createState() => _SignUpSuccessPageState();
}

class _SignUpSuccessPageState extends State<SignUpSuccessPage> {
  @override
  void initState() {
    super.initState();
    login(); // Automatically login when the page is initialized
  }

  Future<void> login() async {
    final url = Uri.parse('${AppConfig.serverAddress}/api/v1/auth/login');
    final headers = {"Content-Type": "application/json"};
    final body =
        jsonEncode({"password": widget.password, "phone_number": widget.phone});

    // Create an instance of FlutterSecureStorage
    final storage = FlutterSecureStorage();

    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseBody = jsonDecode(response.body);
      print(responseBody['status_code']);

      if (responseBody['status_code'] == 200) {
        final accessToken = responseBody['data']['access_token'];
        final refreshToken = responseBody['data']['refresh_token'];

        // Store the tokens in secure storage
        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);

        // Navigate to HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        SnackBarService.showSnackBar(
          context,
          responseBody['detail'],
          true,
        );
      }
    } catch (e) {
      SnackBarService.showSnackBar(
        context,
        'Error occurred: $e',
        true,
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/succes.svg'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Muvaffaqiyatli',
                  style: AppStyle.fontStyle
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' ro‘yxatdan o‘tingiz',
                  style: AppStyle.fontStyle
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Siz endi tizimni ichidagi imkoniyatlardan',
                  style: AppStyle.fontStyle.copyWith(color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'foydalanishingiz va ko‘rishingiz mumkin',
                  style: AppStyle.fontStyle.copyWith(color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text(
                  'Ketdik',
                  style: AppStyle.fontStyle
                      .copyWith(color: AppColors.lightHeaderColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightIconGuardColor,
                  side: BorderSide(color: AppColors.lightIconGuardColor),
                  elevation: 5,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
