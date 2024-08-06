import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final allprovider = Provider.of<AppDataProvider>(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          color: AppColors.lightIconGuardColor,
        ),
        Container(
          // color: AppColors.iconGuardColor,
          width: double.infinity,
          height: 50,

          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/set.png',
                        width: 50,
                        height: 50,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        allprovider.translate('appbartitle1'),
                        style: AppStyle.fontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: allprovider.isDarkTheme
                                ? AppColors.darkTextColor
                                : AppColors.lightTextColor),
                      ),
                      Text(
                        allprovider.translate('appbartitle2'),
                        style: AppStyle.fontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: allprovider.isDarkTheme
                                ? AppColors.darkTextColor
                                : AppColors.lightTextColor),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
