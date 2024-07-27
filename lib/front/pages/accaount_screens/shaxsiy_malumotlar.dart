import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class ShaxsiyMalumotlar extends StatelessWidget {
  const ShaxsiyMalumotlar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightHeaderColor,
      body: SingleChildScrollView(
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
                      SizedBox(
                        width: 20,
                      ),
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
                    keyboardType: TextInputType.text,
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Telefon raqam',
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
                        hintText: '+998 (99) 786-25-51',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.phone,
                          color: AppColors.lightIconGuardColor,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Passport seriyasi va raqami',
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
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    // controller: _phoneController,

                    decoration: const InputDecoration(
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: 'AA 1234567',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.edit_document,
                          color: AppColors.lightIconGuardColor,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Passport berilgan sana',
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
                        hintText: '15.02.2018',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.date_range,
                          color: AppColors.lightIconGuardColor,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Passport kim tomonidan berilgan',
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
                        hintText: 'Toshkent viloyati Qibray tumani',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.corporate_fare,
                          color: AppColors.lightIconGuardColor,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'JSHSHIR',
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
                        hintText: '12 34 56 78 90 12 34',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.code,
                          color: AppColors.lightIconGuardColor,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Manzil',
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
                        hintText: 'Toshkent vil. M.Ulug’bek tum. A.Temur MFY',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.location_on,
                          color: AppColors.lightIconGuardColor,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
