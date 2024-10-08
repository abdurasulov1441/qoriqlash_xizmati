import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class BuildStep4Page extends StatelessWidget {
  const BuildStep4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        SvgPicture.asset('assets/images/ariza_muvofaqiyat.svg'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Arizangiz',
              style: AppStyle.fontStyle
                  .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'muvaffaqiyatli yuborildi',
              style: AppStyle.fontStyle
                  .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Arizangiz ko’rib chiqilib',
              style: AppStyle.fontStyle.copyWith(
                fontSize: 15,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'siz bilan bog’lanamiz',
              style: AppStyle.fontStyle.copyWith(
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF8B2D2D), // Цвет текста кнопки
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Радиус скругления углов
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Отступы внутри кнопки
              ),
              child: Text('Yopish',
                  style: AppStyle.fontStyle.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightHeaderColor)),
            ))
      ],
    );
  }
}
