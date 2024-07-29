import 'package:flutter/material.dart';

import 'package:qoriqlash_xizmati/back/auth_reg_reset/forgot_password/forgot_password.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/reset_password/reset_password_succes.dart';

import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PasswordResetSuccesPage()),
                );
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
