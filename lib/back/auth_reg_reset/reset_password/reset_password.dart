import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:qoriqlash_xizmati/back/auth_reg_reset/forgot_password/forgot_password.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/reset_password/reset_password_succes.dart';
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';
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

    final box = Hive.box<NotesData>('notes');
    String? token = box.getAt(0)?.userToken;

    if (token == null) {
      print('Token is null');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url =
        Uri.parse('http://10.100.9.145:7684/api/v1/auth/change_password');
    //  Uri.parse('http://84.54.96.157:17041/api/v1/auth/change_password');
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

    if (response.statusCode == 200) {
      print('Password changed successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PasswordResetSuccesPage()),
      );
    } else {
      print('Failed to change password: ${response.body}');
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
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PasswordForgotPage()),
                            );
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
