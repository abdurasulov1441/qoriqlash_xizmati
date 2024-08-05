import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/back/auth_reg_reset/login_page/login_page.dart';
import 'dart:convert';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class PasswordForgotSetNewPassPage extends StatefulWidget {
  final String phone;

  const PasswordForgotSetNewPassPage({super.key, required this.phone});

  @override
  _PasswordForgotSetNewPassPageState createState() =>
      _PasswordForgotSetNewPassPageState();
}

class _PasswordForgotSetNewPassPageState
    extends State<PasswordForgotSetNewPassPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _setNewPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final phoneNumber = widget.phone;
      final password = _newPasswordController.text;

      try {
        final response = await http.post(
          Uri.parse(
              'http://10.100.9.145:7684/api/v1/auth/reset_password/confirm'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'phone_number': phoneNumber,
            'password': password,
          }),
        );
        print(password);
        print(phoneNumber);

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password set successfully!')),
          );

          // Navigate to the account screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(responseBody['message'] ?? 'An error occurred')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _setNewPassword,
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
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/password_reset_3.png',
              ),
              Text(
                'Yangi parol',
                style: AppStyle.fontStyle.copyWith(
                    fontSize: 30, color: AppColors.lightIconGuardColor),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    'Yangi parol',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: PasswordField(
                  controller: _newPasswordController,
                  hint: 'Parolni kiriting...',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    'Tasdiqlash parol',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: PasswordField(
                  controller: _confirmPasswordController,
                  hint: 'Parolni kiriting...',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: widget.validator,
    );
  }
}
