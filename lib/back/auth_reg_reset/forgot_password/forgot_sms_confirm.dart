import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'dart:convert';

import 'package:qoriqlash_xizmati/back/auth_reg_reset/forgot_password/set_new_password.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class PasswordForgotSMSConfirmPage extends StatefulWidget {
  final String phone;

  const PasswordForgotSMSConfirmPage({super.key, required this.phone});

  @override
  _PasswordForgotSMSConfirmPageState createState() =>
      _PasswordForgotSMSConfirmPageState();
}

class _PasswordForgotSMSConfirmPageState
    extends State<PasswordForgotSMSConfirmPage> {
  final TextEditingController _smsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _checkVerificationCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      final verificationCode = _smsController.text;
      final phoneNumber = widget.phone;

      try {
        final response = await http.post(
          Uri.parse(
              'http://10.100.9.145:7684/api/v1/auth/check_verification_code'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'phone_number': phoneNumber,
            'verification_code': verificationCode,
          }),
        );

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200 &&
            responseBody['message'] == 'Verification code is correct') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );

          // Navigate to the page to set a new password
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordForgotSetNewPassPage(
                phone: '$phoneNumber',
              ),
            ),
          );
        } else if (response.statusCode == 400 &&
            responseBody['message'] == 'Verification code is incorrect') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An unexpected error occurred')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
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
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _checkVerificationCode,
            child: Text(
              'Yuborish',
              style: AppStyle.fontStyle
                  .copyWith(color: AppColors.lightHeaderColor),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightIconGuardColor,
              side: BorderSide(color: AppColors.lightIconGuardColor),
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Parolni tiklash'),
            Lottie.asset('assets/lotties/forgot_password.json'),
            // Image.asset(
            //   'assets/images/password_reset_2.png',
            // ),
            Text(
              'Parol tasdiqlash',
              style: AppStyle.fontStyle
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Biz sizga 6 tali raqam jo‘natdik',
              style: AppStyle.fontStyle.copyWith(color: Colors.grey),
            ),
            Text(
              maskPhoneNumber(widget.phone),
              style: AppStyle.fontStyle
                  .copyWith(color: AppColors.lightIconGuardColor),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Sonlarni kiriting',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Pinput(
                length: 6,
                controller: _smsController,
                animationCurve: Curves.fastLinearToSlowEaseIn,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the verification code';
                  } else if (value.length != 6) {
                    return 'Verification code must be 6 digits';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
