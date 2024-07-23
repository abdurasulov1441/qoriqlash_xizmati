import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class ArizaTexnikObyekt extends StatelessWidget {
  const ArizaTexnikObyekt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          MiniRedAppBar(),
          MiniRedTitle(title: 'Arizani Rasmiylashtirish'),
          Expanded(child: ArizaStep())
        ],
      ),
    ));
  }
}

class ArizaStep extends StatelessWidget {
  const ArizaStep({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiStepForm();
  }
}

class MultiStepForm extends StatefulWidget {
  const MultiStepForm({super.key});

  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStepPage1(),
                _buildStepPage2(),
                _buildStepPage3(),
                _buildStepPage4(),
              ],
            ),
          ),
          _currentStep < 3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.lightIconGuardColor,
                        backgroundColor: Colors.white, // Text color
                        side: BorderSide(
                            color: AppColors.lightIconGuardColor,
                            width: 2), // Border color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14), // Rounded corners
                        ),
                      ),
                      onPressed: _currentStep > 0 ? _previousStep : null,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back,
                              color: AppColors.lightIconGuardColor),
                          SizedBox(width: 4),
                          Text('Oldingisi'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16), // Space between buttons
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            AppColors.lightIconGuardColor, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14), // Rounded corners
                        ),
                      ),
                      onPressed: _currentStep < 3 ? _nextStep : null,
                      child: Row(
                        children: [
                          Text('Keyingisi'),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _buildStepPage1() {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.network(
              'https://appdata.uz/qbb-data/step1.svg',
              width: 50,
              height: 50,
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    'Hududni tanlang',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ]),
              ],
            ))
      ],
    );
  }

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

  Widget _buildStepPage3() {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.network(
              'https://appdata.uz/qbb-data/step3.svg',
              width: 50,
              height: 50,
            )),
      ],
    );
  }

  Widget _buildStepPage4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        SvgPicture.network('https://appdata.uz/qbb-data/ariza_muvofaqiyat.svg'),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 70,
            child: Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _currentStep = 0;
                  pushScreenWithNavBar(context, HomePage());
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
              ),
            ))
      ],
    );
  }
}
