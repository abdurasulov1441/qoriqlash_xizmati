import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/accaount_screens/xavfsizlik.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class PasswordForgotPage extends StatelessWidget {
  const PasswordForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              pushScreenWithoutNavBar(context, PasswordForgotSMSConfirmPage());
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
              'assets/images/password_reset_1.png',
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Telefon raqam',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                style: const TextStyle(color: AppColors.lightTextColor),
                keyboardType: TextInputType.phone,
                autocorrect: false,
                // controller: _phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                  LengthLimitingTextInputFormatter(13), // Ограничение на длину
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым';
                  } else if (value.length != 13) {
                    return 'Длина номера должна быть 13 символов';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    fillColor: AppColors.fillColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintText: '+998901234567 formatida',
                    hintStyle: AppStyle.fontStyle,
                    label: Icon(
                      Icons.phone,
                      color: AppColors.lightIconGuardColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
