import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:pinput/pinput.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/account_screen.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class XavfsizlikPage extends StatelessWidget {
  const XavfsizlikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                pushScreenWithoutNavBar(context, PasswordResetSuccesPage());
              },
              child: Text(
                'Tasdiqlash',
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
        body: Container(
          child: Column(
            children: [
              MiniRedAppBar(),
              MiniRedTitle(title: 'Xavfsizlik'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Avvalgi parol',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    PasswordField(hint: 'Parolni kiriting...'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Yangi parol',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    PasswordField(hint: 'Parolni kiriting...'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Tasdiqlash parol',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    PasswordField(hint: 'Parolni kiriting...'),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pushScreenWithoutNavBar(
                                context, PasswordForgotPage());
                            // Implement forgot password functionality
                          },
                          child: Text(
                            'Parolni unutdingizmi',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class PasswordField extends StatefulWidget {
  final String hint;

  const PasswordField({super.key, required this.hint});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(
          Icons.lock,
          color: AppColors.lightIconGuardColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

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

class PasswordForgotPage extends StatelessWidget {
  const PasswordForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              pushScreenWithoutNavBar(context, PasswordForgotSMSConfirmPage());
            },
            child: Text(
              'Yuborish',
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
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Parolni tiklash'),
            Image.asset(
              'assets/images/password_reset_1.png',
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Telefon raqam',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                style: const TextStyle(color: AppColors.lightTextColor),
                keyboardType: TextInputType.phone,
                autocorrect: false,
                // controller: _phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                  LengthLimitingTextInputFormatter(13), // Ограничение на длину
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле не может быть пустым';
                  } else if (value.length != 13) {
                    return 'Длина номера должна быть 13 символов';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    fillColor: AppColors.fillColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintText: '+998901234567 formatida',
                    hintStyle: AppStyle.fontStyle,
                    label: Icon(
                      Icons.phone,
                      color: AppColors.lightIconGuardColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordForgotSMSConfirmPage extends StatelessWidget {
  const PasswordForgotSMSConfirmPage({super.key});
  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length >= 11) {
      return phoneNumber.replaceRange(4, 10, '******');
    }
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              pushScreenWithoutNavBar(context, PasswordForgotSetNewPassPage());
            },
            child: Text(
              'Yuborish',
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
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Parolni tiklash'),
            Image.asset(
              'assets/images/password_reset_2.png',
            ),
            Text(
              'Parol tasdiqlash',
              style: AppStyle.fontStyle
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Biz sizga 6 tali raqam jo‘natdik',
              style: AppStyle.fontStyle.copyWith(color: Colors.grey),
            ),
            // Text(
            //   maskPhoneNumber('+${widget.phone}'),
            //   style: AppStyle.fontStyle
            //       .copyWith(color: AppColors.lightIconGuardColor),
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Sonlarni kiriting',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              animationCurve: Curves.fastLinearToSlowEaseIn,
              // controller: _smsController,
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordForgotSetNewPassPage extends StatelessWidget {
  const PasswordForgotSetNewPassPage({super.key});

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
              'Tasdiqlash',
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
          children: [
            Image.asset(
              'assets/images/password_reset_3.png',
            ),
            Text(
              'Yangi parol',
              style: AppStyle.fontStyle
                  .copyWith(fontSize: 30, color: AppColors.lightIconGuardColor),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Avvalgi parol',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: PasswordField(hint: 'Parolni kiriting...'),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Tasdiqlash parol',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: PasswordField(hint: 'Parolni kiriting...'),
            ),
          ],
        ),
      ),
    );
  }
}
