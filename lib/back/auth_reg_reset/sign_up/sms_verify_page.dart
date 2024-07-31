import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:pinput/pinput.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/sign_up/sign_up_succes_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class ConfirmSmsPage extends StatefulWidget {
  final String phone;
  final String password;
  final String code;

  ConfirmSmsPage({
    super.key,
    required this.phone,
    required this.password,
    required this.code,
  });

  @override
  _ConfirmSmsPageState createState() => _ConfirmSmsPageState();
}

class _ConfirmSmsPageState extends State<ConfirmSmsPage> {
  final TextEditingController _smsController = TextEditingController();
  bool _mounted = true;

  @override
  void dispose() {
    _mounted = false;
    _smsController.dispose();
    super.dispose();
  }

  Future<http.Client> _createHttpClient() async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpClient = new IOClient(ioc);
    return httpClient;
  }

  Future<void> _verifyCode() async {
    final httpClient = await _createHttpClient();

    final response = await httpClient.post(
      Uri.parse('http://10.100.9.145:7684/api/v1/auth/check_verification_code'),
      //  Uri.parse(
      //   'http://84.54.96.157:17041/api/v1/auth/check_verification_code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone_number': widget.phone,
        'verification_code': _smsController.text,
      }),
    );

    if (_mounted) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login Successful\nPhone: ${widget.phone}\nPassword: ${widget.password}',
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpSuccessPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to verify code: ${response.body}')),
        );
      }
    }
  }

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length >= 11) {
      return phoneNumber.replaceRange(4, 10, '******');
    }
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        height: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/sms_verify.png'),
              ],
            ),
            Text(
              'Sms ni tasdiqlash',
              style: AppStyle.fontStyle
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Biz sizga 6 tali raqam jo‘natdik',
              style: AppStyle.fontStyle.copyWith(color: Colors.grey),
            ),
            Text(
              maskPhoneNumber('${widget.phone}'),
              style: AppStyle.fontStyle
                  .copyWith(color: AppColors.lightIconGuardColor),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Tasdiqlash kodini kiriting',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              animationCurve: Curves.fastLinearToSlowEaseIn,
              controller: _smsController,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyCode,
                child: Text(
                  'Akkauntni tasdiqlash va yaratish',
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
