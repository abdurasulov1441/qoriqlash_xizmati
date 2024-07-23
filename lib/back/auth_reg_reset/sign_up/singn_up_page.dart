import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/io_client.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:pinput/pinput.dart';
import 'package:qoriqlash_xizmati/back/api/api_sms.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/sign_up/sms_verify_page.dart';
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
                      height: 10,
                    ),
                    TextFormField(
                      style: const TextStyle(color: AppColors.lightTextColor),
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      controller: _phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(
                            12), // Ограничение на длину
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else if (value.length != 12) {
                          return 'Длина номера должна быть 12 символов';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '998901234567 formatida',
                          hintStyle: AppStyle.fontStyle,
                          label: Icon(
                            Icons.phone,
                            color: AppColors.lightIconGuardColor,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Parol',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                    const SizedBox(
                      height: 10,
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
