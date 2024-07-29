import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/forgot_password/set_new_password.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class PasswordForgotSMSConfirmPage extends StatelessWidget {
  const PasswordForgotSMSConfirmPage({super.key});
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PasswordForgotSetNewPassPage()),
              );
            },
            child: Text(
              'Yuborish',
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
        ),
      ),
      body: Center(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Parolni tiklash'),
            Image.asset(
              'assets/images/password_reset_2.png',
            ),
            Text(
              'Parol tasdiqlash',
              style: AppStyle.fontStyle
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Biz sizga 6 tali raqam jo‘natdik',
              style: AppStyle.fontStyle.copyWith(color: Colors.grey),
            ),
            // Text(
            //   maskPhoneNumber('+${widget.phone}'),
            //   style: AppStyle.fontStyle
            //       .copyWith(color: AppColors.lightIconGuardColor),
            // ),
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
            Pinput(
              length: 6,
              animationCurve: Curves.fastLinearToSlowEaseIn,
              // controller: _smsController,
            ),
          ],
        ),
      ),
    );
  }
}
