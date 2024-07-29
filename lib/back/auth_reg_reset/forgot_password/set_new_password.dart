import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/reset_password/reset_password.dart';
import 'package:qoriqlash_xizmati/front/pages/account_screen.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class PasswordForgotSetNewPassPage extends StatelessWidget {
  const PasswordForgotSetNewPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              pushScreenWithoutNavBar(context, AccountScreen());
            },
            child: Text(
              'Tasdiqlash',
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
            Image.asset(
              'assets/images/password_reset_3.png',
            ),
            Text(
              'Yangi parol',
              style: AppStyle.fontStyle
                  .copyWith(fontSize: 30, color: AppColors.lightIconGuardColor),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Avvalgi parol',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: PasswordField(hint: 'Parolni kiriting...'),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Tasdiqlash parol',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: PasswordField(hint: 'Parolni kiriting...'),
            ),
          ],
        ),
      ),
    );
  }
}
