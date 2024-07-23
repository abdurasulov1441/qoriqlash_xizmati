import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class ButtonWithRadius extends StatelessWidget {
  const ButtonWithRadius({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Karta qo\'shish',
          style: AppStyle.fontStyle.copyWith(color: AppColors.lightHeaderColor),
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
    );
  }
}
