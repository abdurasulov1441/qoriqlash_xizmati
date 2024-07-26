import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/back/snack_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid)
      return;
    else {
      SnackBarService.showSnackBar(
        context,
        'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
        true,
      );
      return;
    }
  }

  // navigator.pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: AppColors.lightHeaderColor,
      //   centerTitle: true,
      //   // leading: IconButton(
      //   //     onPressed: () {
      //   //       Navigator.pop(context);
      //   //     },
      //   //     icon: Icon(
      //   //       Icons.arrow_back,
      //   //       color: AppColors.textColor,
      //   //     )),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Xush kelibsiz !',
                      style: AppStyle.fontStyle
                          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Tizimga kirishingiz mumkin',
                      style: AppStyle.fontStyle
                          .copyWith(color: AppColors.lightDividerColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/set.png',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Qo\'riqlash Xizmati'.toUpperCase(),
                      style: AppStyle.fontStyle
                          .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
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
                      style:
                          const TextStyle(color: AppColors.lightDividerColor),
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: '998901234567 formatida',
                        hintStyle: AppStyle.fontStyle,
                        label: Icon(
                          Icons.phone,
                          color: AppColors.lightIconGuardColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          'Parol',
                          style: AppStyle.fontStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style:
                          const TextStyle(color: AppColors.lightDividerColor),
                      autocorrect: false,
                      controller: passwordTextInputController,
                      obscureText: isHiddenPassword,
                      validator: (value) => value != null && value.length < 6
                          ? 'Минимум 6 символов'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        hintText: 'Parolingizni kiriting',
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed('/reset_password'),
                          child: Text(
                            'Parolingizni unutdingizmi?',
                            style: AppStyle.fontStyle
                                .copyWith(color: AppColors.lightIconGuardColor),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColors.lightIconGuardColor),
                      onPressed: login,
                      child: Center(
                          child: Text(
                        'Kirish',
                        style: AppStyle.fontStyle.copyWith(
                            color: AppColors.lightBackgroundColor,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Akkauntingiz yo\'qmi?',
                      style: AppStyle.fontStyle,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ro\'yxatdan o\'ting',
                          style: AppStyle.fontStyle
                              .copyWith(color: AppColors.lightIconGuardColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
