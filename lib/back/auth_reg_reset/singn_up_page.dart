import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:pinput/pinput.dart';
import 'package:qoriqlash_xizmati/back/snack_bar.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool isHiddenPassword = true;

  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    // Generate a random 6-digit code
    final random = Random();
    final code = (random.nextInt(9000) + 1000).toString();

    // Send the SMS (this should be done through your SMS service)
    SmsService().sendSms([
      {
        'phone': _phoneController.text,
        'text': 'Qo\'riqlash xizmati shaxsiy kabineti uchun kod: $code'
      }
    ]);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmSmsPage(
          phone: _phoneController.text,
          password: passwordTextInputController.text,
          code: code,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const MiniRedAppBar(),
              Container(
                width: double.infinity,
                height: 200,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Yangi Akkaunt Yarating',
                      style: AppStyle.fontStyle
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/set.png',
                      width: 80,
                      height: 80,
                    ),
                    Text(
                      'Qo\'riqlash Xizmati',
                      style: AppStyle.fontStyle
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Telefon raqam',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.lightTextColor),
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: 'Telefon raqamni kiriting',
                          hintStyle: AppStyle.fontStyle,
                          label: Icon(
                            Icons.phone,
                            color: AppColors.lightIconGuardColor,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Parol',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.lightTextColor),
                      autocorrect: false,
                      controller: passwordTextInputController,
                      obscureText: isHiddenPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Минимум 6 символов'
                          : null,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: 'Parolni kiriting',
                        hintStyle: AppStyle.fontStyle,
                        label: const Icon(
                          Icons.lock,
                          color: AppColors.lightIconGuardColor,
                        ),
                        suffix: InkWell(
                          onTap: togglePasswordView,
                          child: Icon(
                            isHiddenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.lightTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Parolni tasdiqlash',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.lightTextColor),
                      autocorrect: false,
                      controller: passwordTextRepeatInputController,
                      obscureText: isHiddenPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Минимум 6 символов'
                          : null,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: 'Parolni yana bir martda tering',
                        hintStyle: AppStyle.fontStyle,
                        label: const Icon(
                          Icons.lock,
                          color: AppColors.lightIconGuardColor,
                        ),
                        suffix: InkWell(
                          onTap: togglePasswordView,
                          child: Icon(
                              isHiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.lightTextColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                              color: AppColors.lightBackgroundColor),
                          backgroundColor: AppColors.lightIconGuardColor),
                      // onPressed: () {
                      //   pushScreenWithoutNavBar(
                      //       context,
                      //       ConfirmSmsPage(
                      //         code: '',
                      //         phone: '',
                      //         password: '',
                      //       ));
                      // },
                      onPressed:
                          signUp, ////////////////////////////////////////////////////////////////////////////
                      child: Center(
                          child: Text(
                        'Ro\'yxatdan o\'tish',
                        style: AppStyle.fontStyle
                            .copyWith(color: AppColors.lightBackgroundColor),
                      )),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Akkauntingiz bormi?',
                          style: AppStyle.fontStyle,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Kirish',
                              style: AppStyle.fontStyle.copyWith(
                                  color: AppColors.lightIconGuardColor)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmsService {
  final String login = 'Qoriqlash';
  final String password = 'WNM63NWR7C6VwwT98RG7';
  final String url = 'https://appdata.uz/sms_proxy.php';

  Future<void> sendSms(List<Map<String, String>> messages) async {
    final data = {
      'login': login,
      'password': password,
      'data': jsonEncode(messages),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: data,
    );

    if (response.statusCode == 200) {
      print('SMS sent successfully: ${response.body}');
    } else {
      print('Failed to send SMS: ${response.body}');
    }
  }
}

class ConfirmSmsPage extends StatelessWidget {
  final String phone;
  final String password;
  final String code;

  ConfirmSmsPage({
    super.key,
    required this.phone,
    required this.password,
    required this.code,
  });

  final TextEditingController _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _verifyCode() {
      if (_smsController.text == code) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login Successful\nPhone: $phone\nPassword: $password',
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SingnUpSuccesPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid SMS code')),
        );
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        height: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/sms_verify.png'),
              ],
            ),
            Text(
              'Sms ni tasdiqlash',
              style: AppStyle.fontStyle
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Biz sizga 4 tali raqam jo‘natdik',
              style: AppStyle.fontStyle.copyWith(color: Colors.grey),
            ),
            Text(
              '+$phone',
              style: AppStyle.fontStyle
                  .copyWith(color: AppColors.lightIconGuardColor),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Tasdiqlash kodini kiriting',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Pinput(
              animationCurve: Curves.fastLinearToSlowEaseIn,
              controller: _smsController,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _verifyCode();
                },
                child: Text(
                  'Akkauntni tasdiqlash va yaratish',
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
            )
          ],
        ),
      ),
    );
  }
}

class SingnUpSuccesPage extends StatelessWidget {
  const SingnUpSuccesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/succes.svg'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ha! Muvaffaqiyatli',
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
                  ' ro‘yxatdan o‘tingiz',
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
                  'Siz endi tizimni ichidagi imkoniyatlarda',
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
                Text('foydalanishingiz va ko‘rishingiz mumkin',
                    style: AppStyle.fontStyle.copyWith(
                      color: Colors.grey,
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  pushScreenWithNavBar(context, HomePage());
                },
                child: Text(
                  'Ketdik',
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
            )
          ],
        ),
      ),
    );
  }
}
