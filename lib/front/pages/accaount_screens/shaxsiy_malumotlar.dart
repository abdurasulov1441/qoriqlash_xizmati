import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class ShaxsiyMalumotlar extends StatelessWidget {
  const ShaxsiyMalumotlar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Shaxsiy Ma\'lumotlar'),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 50,
              child: Image.asset('assets/images/person.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'F.I.SH',
                        style: AppStyle.fontStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    style: const TextStyle(color: AppColors.lightTextColor),
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    // controller: _phoneController,

                    decoration: const InputDecoration(
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: 'Rahimov Voris Avazbek o\'g\'li',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.person,
                          color: AppColors.lightIconGuardColor,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
