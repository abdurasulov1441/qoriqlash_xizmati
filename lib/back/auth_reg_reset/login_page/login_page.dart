import 'dart:convert';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/forgot_password/forgot_password.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/sign_up/singn_up_page.dart';
import 'package:qoriqlash_xizmati/back/snack_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHiddenPassword = true;
  TextEditingController phoneTextInputController =
      TextEditingController(text: '+998 ');
  TextEditingController passwordTextInputController = TextEditingController();
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
    phoneTextInputController.dispose();
    passwordTextInputController.dispose();
    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    FocusScope.of(context).unfocus();
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    final url = Uri.parse('${AppConfig.serverAddress}/api/v1/auth/login');
    final headers = {"Content-Type": "application/json"};

    // Retain the '+' and remove other non-digit characters
    final phoneNumber =
        '+${phoneTextInputController.text.substring(1).replaceAll(RegExp(r'\D'), '')}';

    final body = jsonEncode({
      "password": passwordTextInputController.text,
      "phone_number": phoneNumber
    });

    // Debugging: Print the formatted phone number
    print("Phone number to be sent: $phoneNumber");

    // Create an instance of FlutterSecureStorage
    final storage = FlutterSecureStorage();

    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseBody = jsonDecode(response.body);
      print(responseBody['status_code']);

      if (responseBody['status_code'] == 200) {
        final accessToken = responseBody['data']['access_token'];
        final refreshToken = responseBody['data']['refresh_token'];

        // Store the tokens in secure storage
        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        SnackBarService.showSnackBar(
          context,
          responseBody['detail'],
          true,
        );
      }
    } catch (e) {
      SnackBarService.showSnackBar(
        context,
        'Error occurred: $e',
        true,
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Xush kelibsiz !',
                      style: AppStyle.fontStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tizimga kirishingiz mumkin',
                      style: AppStyle.fontStyle.copyWith(
                        color: AppColors.lightDividerColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      'assets/images/set.png',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Qo\'riqlash Xizmati'.toUpperCase(),
                      style: AppStyle.fontStyle.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Telefon raqam',
                          style: AppStyle.fontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      controller: phoneTextInputController,
                      inputFormatters: [
                        _phoneNumberFormatter,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        } else if (value.replaceAll(RegExp(r'\D'), '').length !=
                            12) {
                          return 'Длина номера должна быть 12 символов';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: '+998901234567',
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
                          style: AppStyle.fontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      // style:
                      //     const TextStyle(color: AppColors.lightDividerColor),
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
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PasswordForgotPage()),
                            );
                          },
                          child: AutoSizeText(
                            maxLines: 1,
                            minFontSize: 5,
                            maxFontSize: 12,
                            'Parolingizni unutdingizmi?',
                            style: AppStyle.fontStyle.copyWith(
                              color: AppColors.lightIconGuardColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.lightIconGuardColor,
                      ),
                      onPressed: login,
                      child: Center(
                        child: Text(
                          'Kirish',
                          style: AppStyle.fontStyle.copyWith(
                            color: AppColors.lightBackgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      maxLines: 1,
                      minFontSize: 5,
                      maxFontSize: 12,
                      'Akkauntingiz yo\'qmi?',
                      style: AppStyle.fontStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: AutoSizeText(
                        maxLines: 1,
                        minFontSize: 5,
                        maxFontSize: 12,
                        'Ro\'yxatdan o\'ting',
                        style: AppStyle.fontStyle.copyWith(
                          color: AppColors.lightIconGuardColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 250,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
