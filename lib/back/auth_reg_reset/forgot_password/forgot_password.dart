import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';

import 'package:qoriqlash_xizmati/back/auth_reg_reset/forgot_password/forgot_sms_confirm.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class PasswordForgotPage extends StatefulWidget {
  const PasswordForgotPage({super.key});

  @override
  _PasswordForgotPageState createState() => _PasswordForgotPageState();
}

class _PasswordForgotPageState extends State<PasswordForgotPage> {
  final TextEditingController _phoneController =
      TextEditingController(text: '+998 ');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Future<void> _sendPhoneNumber() async {
    if (_formKey.currentState?.validate() ?? false) {
      final phoneNumber =
          _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

      try {
        final response = await http.put(
          Uri.parse('http://10.100.9.145:7684/api/v1/auth/reset_password'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone_number': '+$phoneNumber'}),
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordForgotSMSConfirmPage(
                phone: '+$phoneNumber',
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to send verification code')),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _sendPhoneNumber,
            child: Text(
              'Yuborish',
              style: AppStyle.fontStyle
                  .copyWith(color: AppColors.lightHeaderColor),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightIconGuardColor,
              side: BorderSide(color: AppColors.lightIconGuardColor),
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Parolni tiklash'),
            Lottie.asset('assets/lotties/forgot_password.json'),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Telefon raqam',
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _phoneController,
                  style: const TextStyle(color: AppColors.lightTextColor),
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
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
                  decoration: const InputDecoration(
                      fillColor: AppColors.fillColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintStyle: AppStyle.fontStyle,
                      label: Icon(
                        Icons.phone,
                        color: AppColors.lightIconGuardColor,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
