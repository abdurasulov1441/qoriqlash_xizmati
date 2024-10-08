import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'dart:convert';

import 'package:qoriqlash_xizmati/back/auth_reg_reset/reset_password/reset_password_succes.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class XavfsizlikPage extends StatefulWidget {
  const XavfsizlikPage({super.key});

  @override
  _XavfsizlikPageState createState() => _XavfsizlikPageState();
}

class _XavfsizlikPageState extends State<XavfsizlikPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    // Create an instance of FlutterSecureStorage
    final storage = FlutterSecureStorage();

    // Retrieve the token from secure storage
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      print('Token is null');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url =
        Uri.parse('${AppConfig.serverAddress}/api/v1/auth/change_password');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'old_password': _oldPasswordController.text,
        'new_password': _newPasswordController.text,
      }),
    );
    final responseBody = jsonDecode(response.body);
    print(responseBody['status']);

    if (responseBody['status'] == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PasswordResetSuccesPage()),
      );
    } else {
      print('o\'rnatilmadi');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.lightHeaderColor),
                    )
                  : Text(
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
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MiniRedAppBar(),
                MiniRedTitle(title: 'Xavfsizlik'),
                Lottie.asset(
                  'assets/lotties/changepass.json',
                  //  width: 200, height: 200
                ),
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
                      PasswordField(
                        controller: _oldPasswordController,
                        hint: 'Parolni kiriting...',
                      ),
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
                      PasswordField(
                        controller: _newPasswordController,
                        hint: 'Parolni kiriting...',
                      ),
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
                      PasswordField(
                        controller: _confirmPasswordController,
                        hint: 'Parolni kiriting...',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class PasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
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
