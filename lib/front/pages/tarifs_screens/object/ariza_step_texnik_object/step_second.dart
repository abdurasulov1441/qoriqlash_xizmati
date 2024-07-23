import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

Widget _buildStepPage2() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
          child: SvgPicture.network(
        'https://appdata.uz/qbb-data/step2.svg',
        width: 50,
        height: 50,
      )),
      SizedBox(
        //margin: EdgeInsets.symmetric(horizontal: 50),
        width: 219,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'O\'zbekiston Respublikasi Milliy Gvardiyasi ',
                  style: AppStyle.fontStyle.copyWith(fontSize: 10),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Toshkent shaxar Qo\'riqlash boshqarmasi ',
                  style: AppStyle.fontStyle.copyWith(fontSize: 10),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ' boshlig\'i',
                  style: AppStyle.fontStyle.copyWith(fontSize: 10),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Q.A.Shodibekovga ',
                  style: AppStyle.fontStyle.copyWith(fontSize: 10),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '"Google" kompaniyasi',
                  style: AppStyle.fontStyle
                      .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Direktori: Raximov V.A',
                  style: AppStyle.fontStyle.copyWith(fontSize: 10),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Telefon: (99)-786-25-51',
                  style: AppStyle.fontStyle.copyWith(fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
          width: double.infinity,
          // height: 50,
          child: AutoSizeText(
            maxLines: 3,
            '       Sizga, shuni ma’lum qilamizki Mirzo Ulug’bek tumani, A.Navoiy MFY Shodlik ko’chasi 17-uy joylashgan tashkilotimiz Qo’riqlovi va xavfsizligini Ta’minlash maqsadida ',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Perimetr(Harakat sezgi sensorlari)',
            style: AppStyle.fontStyle
                .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            'Ish kunlari 09:00 / 17:00',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            'Shanba va Yakshanba kunlari --:-- / --:--',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            'Bayram kunlari --:-- / --:--',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Perimetr(Harakat sezgi sensorlari)',
            style: AppStyle.fontStyle
                .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            'Ish kunlari 09:00 / 17:00',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            'Shanba va Yakshanba kunlari --:-- / --:--',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            'Bayram kunlari --:-- / --:--',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
          width: double.infinity,
          // height: 50,
          child: AutoSizeText(
            maxLines: 3,
            'TQM qo’riqloviga ulab  shartnoma tuzishda amaliy yordam berishingizni so’raymiz. Qo’riqlov uchun oylik to’lovlarni kafolatlaymiz',
            style: AppStyle.fontStyle.copyWith(fontSize: 10),
          ),
        ),
      ),
      const SizedBox(
        height: 100,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '«18» iyul 2024 yil ',
                style: AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Row(
                children: [Text('"Google" kompaniyasi')],
              ),
              const Row(
                children: [Text('Direktori: Raximov V.A')],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Imzolash'))
                ],
              ),
            ],
          )
        ],
      )
    ],
  );
}

class BuildStep2Page extends StatelessWidget {
  const BuildStep2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            child: SvgPicture.network(
          'https://appdata.uz/qbb-data/step2.svg',
          width: 50,
          height: 50,
        )),
        SizedBox(
          //margin: EdgeInsets.symmetric(horizontal: 50),
          width: 219,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'O\'zbekiston Respublikasi Milliy Gvardiyasi ',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Toshkent shaxar Qo\'riqlash boshqarmasi ',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ' boshlig\'i',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Q.A.Shodibekovga ',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"Google" kompaniyasi',
                    style: AppStyle.fontStyle
                        .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Direktori: Raximov V.A',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Telefon: (99)-786-25-51',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: double.infinity,
            // height: 50,
            child: AutoSizeText(
              maxLines: 3,
              '       Sizga, shuni ma’lum qilamizki Mirzo Ulug’bek tumani, A.Navoiy MFY Shodlik ko’chasi 17-uy joylashgan tashkilotimiz Qo’riqlovi va xavfsizligini Ta’minlash maqsadida ',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Perimetr(Harakat sezgi sensorlari)',
              style: AppStyle.fontStyle
                  .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              'Ish kunlari 09:00 / 17:00',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              'Shanba va Yakshanba kunlari --:-- / --:--',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              'Bayram kunlari --:-- / --:--',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Perimetr(Harakat sezgi sensorlari)',
              style: AppStyle.fontStyle
                  .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              'Ish kunlari 09:00 / 17:00',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              'Shanba va Yakshanba kunlari --:-- / --:--',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              'Bayram kunlari --:-- / --:--',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: double.infinity,
            // height: 50,
            child: AutoSizeText(
              maxLines: 3,
              'TQM qo’riqloviga ulab  shartnoma tuzishda amaliy yordam berishingizni so’raymiz. Qo’riqlov uchun oylik to’lovlarni kafolatlaymiz',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  '«18» iyul 2024 yil ',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Row(
                  children: [Text('"Google" kompaniyasi')],
                ),
                const Row(
                  children: [Text('Direktori: Raximov V.A')],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Imzolash'))
                  ],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
