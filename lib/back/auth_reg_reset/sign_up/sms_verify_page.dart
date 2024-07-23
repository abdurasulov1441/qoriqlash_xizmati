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

  Future<void> _sendDataToServer() async {
    final httpClient = await _createHttpClient();

    final response = await httpClient.post(
      Uri.parse('https://appdata.uz/get_login.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': widget.phone,
        'password': widget.password,
      }),
    );

    if (_mounted) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data sent successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send data to the server')),
        );
      }
    }
  }

  void _verifyCode() {
    if (_smsController.text == widget.code) {
      _sendDataToServer();
      if (_mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login Successful\nPhone: ${widget.phone}\nPassword: ${widget.password}',
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SingnUpSuccesPage()),
        );
      }
    } else {
      if (_mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid SMS code')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String maskPhoneNumber(String phoneNumber) {
      if (phoneNumber.length >= 11) {
        return phoneNumber.replaceRange(4, 10, '******');
      }
      return phoneNumber;
    }

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
              'Biz sizga 4 tali raqam jo‘natdik',
              style: AppStyle.fontStyle.copyWith(color: Colors.grey),
            ),
            Text(
              maskPhoneNumber('+${widget.phone}'),
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
