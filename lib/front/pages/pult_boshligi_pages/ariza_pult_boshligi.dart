import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class ArizaPultBoshligiPage extends StatelessWidget {
  const ArizaPultBoshligiPage({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Ariza № $index'),
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            width: 230,
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 10,
                              maxLines: 3,
                              'O’zbekiston Respublikasi Milliy Gvardiyasi Toshkent Shahar Qo’riqlash boshqarmasi Boshlig’i',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              'Q.A.Shodibekovga',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 180, right: 10),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fuqaro: Raximov V.A.',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                            Text(
                              'Tumani: Mirzo Ulug’bek',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                            Text(
                              'MFY: Alisher Navoiy',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                            Text(
                              'Ko’cha: Shodlik',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                            Text(
                              'Uy raqami: №2',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                            Text(
                              'Kvartira raqami: №5',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                            Text(
                              'Telefon raqami: +998 (99) 786-25-51',
                              style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Ariza',
                        style: AppStyle.fontStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText(
                            style: AppStyle.fontStyle.copyWith(fontSize: 10),
                            '         Yuqorida ko’rsatilgan xonadonni harakat sezgi sensorlari va tashvish xabar orqali 8-soat qo’riqlovga olishda amaliy yordam berishingizni so’rayman. Qo’riqlov uchun oylik to’lovlarni kafolatlaymiz'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('«18» iyul 2024 yil '),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: 250,
                            child: AutoSizeText(
                                textAlign: TextAlign.justify,
                                minFontSize: 8,
                                style: AppStyle.fontStyle.copyWith(fontSize: 8),
                                'Mazkur hujjat Vazirlar Mahkamasining 2017 yil 15 sentyabrdagi 728-son qaroriga  muvofiq Yagona interaktiv davlat xizmatlari portalida shakllantirilgan elektron  hujjatning nusxasi bo‘lib, davlat organlari tomonidan ushbu hujjatni qabul qilishni rad  etishlari qat’iyan taqiqlanadi. Hujjat haqiqiyligini repo.gov.uz veb-saytida hujjatning  noyob raqamini kiritib yoki mobil telefon yordamida QR- kodni skaner qilish orqali  tekshirish mumkin.'),
                          ),
                          Text(
                            '1485',
                            style: AppStyle.fontStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/800px-QR_code_for_mobile_English_Wikipedia.svg.png',
                            width: 80,
                            height: 80,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColors.lightIconGuardColor),
                        onPressed: () {},
                        child: Text(
                          'Bayonnoma',
                          style: AppStyle.fontStyle
                              .copyWith(color: AppColors.lightHeaderColor),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColors.lightIconGuardColor),
                        onPressed: () {},
                        child: Text(
                          'Dalolatnoma',
                          style: AppStyle.fontStyle
                              .copyWith(color: AppColors.lightHeaderColor),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColors.lightIconGuardColor),
                        onPressed: () {},
                        child: Column(
                          children: [
                            Text(
                              'Shartnoma',
                              style: AppStyle.fontStyle
                                  .copyWith(color: AppColors.lightHeaderColor),
                            ),
                            Text(
                              ' ilovasi',
                              style: AppStyle.fontStyle
                                  .copyWith(color: AppColors.lightHeaderColor),
                            ),
                          ],
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColors.lightIconGuardColor),
                        onPressed: () {},
                        child: Text(
                          'Shartnoma',
                          style: AppStyle.fontStyle
                              .copyWith(color: AppColors.lightHeaderColor),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
