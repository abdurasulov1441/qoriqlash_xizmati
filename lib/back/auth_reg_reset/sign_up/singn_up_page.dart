import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/sign_up/sms_verify_page.dart';
import 'package:qoriqlash_xizmati/back/snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';
import 'dart:math';

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
  final TextEditingController _phoneController =
      TextEditingController(text: '+998 ');
  final formKey = GlobalKey<FormState>();

  final _phoneNumberFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      if (!newValue.text.startsWith('+998 ')) {
        return oldValue;
      }

      String text = newValue.text.substring(5).replaceAll(RegExp(r'\D'), '');

      if (text.length > 9) {
        text = text.substring(0, 9);
      }

      StringBuffer formatted = StringBuffer('+998 ');
      int selectionIndex = newValue.selection.baseOffset;

      if (text.length > 0)
        formatted.write('(${text.substring(0, min(2, text.length))}');
      if (text.length > 2)
        formatted.write(') ${text.substring(2, min(5, text.length))}');
      if (text.length > 5)
        formatted.write(' ${text.substring(5, min(7, text.length))}');
      if (text.length > 7)
        formatted.write(' ${text.substring(7, text.length)}');

      selectionIndex = formatted.length;

      if (newValue.selection.baseOffset < 5) {
        selectionIndex = 5;
      }

      return TextEditingValue(
        text: formatted.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    },
  );

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
    FocusScope.of(context).unfocus();
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Parollar mos kelishi kerak',
        true,
      );
      return;
    }

    // Process the phone number to remove any non-numeric characters except '+'
    final phoneNumber = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    final url = Uri.parse('${AppConfig.serverAddress}/api/v1/auth/register');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "password": passwordTextInputController.text,
      "phone_number": '+$phoneNumber'
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      print(response.statusCode);
      print(response.body);

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmSmsPage(
                phone: '+$phoneNumber',
                password: passwordTextInputController.text,
                code: '',
              ),
            ),
          );
        }
      } else {
        SnackBarService.showSnackBar(
          context,
          'Registratsiada xatolik yuz berdi',
          true,
        );
      }
    } catch (e) {
      SnackBarService.showSnackBar(
        context,
        'Server bilan aloqa mavjud emas',
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
                      inputFormatters: [
                        _phoneNumberFormatter,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bo\'sh bo\'lmasligi lozim';
                        } else if (value.replaceAll(RegExp(r'\D'), '').length !=
                            12) {
                          return 'Telefon raqam uzunligi 9 belgidan kam bo\'lmasligi kerak';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          fillColor: AppColors.fillColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: '+998901234567',
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
                      validator: (value) => value != null && value.length < 8
                          ? 'Kamida 8 belgidan kam bo\'lmasligi kerak'
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
                      validator: (value) => value != null && value.length < 8
                          ? 'Kamida 8 belgidan kam bo\'lmasligi kerak'
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
                          onPressed: () => Navigator.pop(
                            context,
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
              SizedBox(
                height: 250,
              )
            ],
          ),
        ),
      ),
    );
  }
}
