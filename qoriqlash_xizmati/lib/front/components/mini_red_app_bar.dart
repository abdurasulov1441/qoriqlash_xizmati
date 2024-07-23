import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class MiniRedAppBar extends StatelessWidget {
  const MiniRedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightIconGuardColor,
      width: double.infinity,
      height: 30,
      child: const Card(
        elevation: 10,
        color: Colors.transparent,
      ),
    );
  }
}

class MiniRedTitle extends StatelessWidget {
  const MiniRedTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightHeaderRed,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.lightIconGuardColor,
              )),
          Text(
            title,
            style: AppStyle.fontStyle.copyWith(
                color: AppColors.lightIconGuardColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
