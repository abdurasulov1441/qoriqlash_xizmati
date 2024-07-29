import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';
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
    if (!isValid) return;

    final url = Uri.parse('http://10.100.9.145:7684/api/v1/auth/login');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "password": passwordTextInputController.text,
      "phone_number": emailTextInputController.text
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['data']['access_token'];
        var box = Hive.box<NotesData>('notes');

        // Check if data exists at index 0 and delete if necessary
        if (box.isNotEmpty && box.length > 0) {
          box.deleteAt(0);
        }

        await box.putAt(0, NotesData(isChecked: true, userToken: accessToken));

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        SnackBarService.showSnackBar(
          context,
          'Failed to log in: ${response.body}',
          true,
        );
      }
    } catch (e) {
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
                      style:
                          const TextStyle(color: AppColors.lightDividerColor),
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      controller: emailTextInputController,
                      decoration: const InputDecoration(
                        fillColor: AppColors.fillColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
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
                          style: AppStyle.fontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
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
                          onPressed: () => Navigator.of(context)
                              .pushNamed('/reset_password'),
                          child: Text(
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
                    const Text(
                      'Akkauntingiz yo\'qmi?',
                      style: AppStyle.fontStyle,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Ro\'yxatdan o\'ting',
                        style: AppStyle.fontStyle.copyWith(
                          color: AppColors.lightIconGuardColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
