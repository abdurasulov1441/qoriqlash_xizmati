import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/front/pages/account_screen.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class PasswordResetSuccesPage extends StatelessWidget {
  const PasswordResetSuccesPage({super.key});

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
              'Kettik',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/succes.svg'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Parolingiz',
                  style: AppStyle.fontStyle
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'muvaffaqiyatli o’zgartirildi',
                  style: AppStyle.fontStyle
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Siz endi tizimdan yangi parolingiz orqali',
                  style: AppStyle.fontStyle.copyWith(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('foydalanishingiz mumkin',
                    style: AppStyle.fontStyle.copyWith(
                      color: Colors.grey,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
