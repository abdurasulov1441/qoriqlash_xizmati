import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/login_page/login_page.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/sign_up/sms_verify_page.dart';
import 'package:qoriqlash_xizmati/back/snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

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

    final url = Uri.parse('http://10.100.9.145:7684/api/v1/auth/register');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "password": passwordTextInputController.text,
      "phone_number": _phoneController.text
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status_code'] == 400) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Xatolik!'),
                content: Text('Ushbu foydalanuvchi mavjud'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Save token to Hive
          // final userToken = responseBody['token'];
          // var box = Hive.box<NotesData>('notes');
          // box.put('user_data', NotesData(userToken: userToken));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmSmsPage(
                phone: _phoneController.text,
                password: passwordTextInputController.text,
                code: '', // No code generated
              ),
            ),
          );
        }
      } else {
        // Handle error response
        SnackBarService.showSnackBar(
          context,
          'Failed to register user: ${response.body}',
          true,
        );
      }
    } catch (e) {
      // Handle network or other errors
      SnackBarService.showSnackBar(
        context,
        'Error occurred: $e',
        true,
      );
    }
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
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                height: 220,
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
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Qo\'riqlash Xizmati'.toUpperCase(),
                      style: AppStyle.fontStyle
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
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
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                      //   LengthLimitingTextInputFormatter(
                      //       13), // Ограничение на длину
                      // ],
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '+998901234567 formatida',
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
                        fillColor: AppColors.fillColor,
                        filled: true,
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
                        fillColor: AppColors.fillColor,
                        filled: true,
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
                      onPressed: signUp,
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
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          ),
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
