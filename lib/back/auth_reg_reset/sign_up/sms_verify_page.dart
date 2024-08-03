import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:pinput/pinput.dart';
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'package:qoriqlash_xizmati/back/auth_reg_reset/sign_up/sign_up_succes_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';
import 'package:telephony/telephony.dart';

class ConfirmSmsPage extends StatefulWidget {
  final String phone;
  final String password;
  final String code;

  ConfirmSmsPage({
    super.key,
    required this.phone,
    required this.password,
    required this.code,
  });

  @override
  _ConfirmSmsPageState createState() => _ConfirmSmsPageState();
}

class _ConfirmSmsPageState extends State<ConfirmSmsPage> {
  final TextEditingController _smsController = TextEditingController();
  final Telephony telephony = Telephony.instance;
  bool _mounted = true;
  bool _isButtonEnabled = false;
  String otpcode = "";
  late PinTheme currentPinTheme;

  @override
  void initState() {
    super.initState();
    _listenIncomingSms();
    _smsController.addListener(_onCodeChanged);
    currentPinTheme = defaultPinTheme; // Set initial theme
  }

  void _listenIncomingSms() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print("Message from: ${message.address}");
        print("Message body: ${message.body}");

        // Регулярное выражение для извлечения кода после "kodi: "
        final regExp = RegExp(r'kodi:\s+(\d{6})');
        final match = regExp.firstMatch(message.body!);
        if (match != null) {
          otpcode = match.group(1)!; // Получаем код
          _smsController.text = otpcode; // Обновляем контроллер текста
          setState(() {
            _isButtonEnabled = otpcode.isNotEmpty; // Активируем кнопку
          });
        } else {
          print("SMS does not contain a valid code.");
        }
      },
      listenInBackground: false,
    );
  }

  @override
  void dispose() {
    _mounted = false;
    _smsController.removeListener(_onCodeChanged);
    _smsController.dispose();
    super.dispose();
  }

  void _onCodeChanged() {
    setState(() {
      _isButtonEnabled = _smsController.text.isNotEmpty;
    });
  }

  Future<http.Client> _createHttpClient() async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpClient = new IOClient(ioc);
    return httpClient;
  }

  Future<void> _checkStatus() async {
    final httpClient = await _createHttpClient();

    final response = await httpClient.post(
      Uri.parse(
          '${AppConfig.serverAddress}/api/v1/auth/check_verification_code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone_number': widget.phone,
        'verification_code': _smsController.text,
      }),
    );
    var jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == 200) {
      currentPinTheme = succesPinTheme;
    } else if (jsonResponse['status'] == 400) {
      currentPinTheme = errorPinTheme;
    }
  }

  Future<void> _verifyCode() async {
    final httpClient = await _createHttpClient();

    final response = await httpClient.post(
      Uri.parse(
          '${AppConfig.serverAddress}/api/v1/auth/check_verification_code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone_number': widget.phone,
        'verification_code': _smsController.text,
      }),
    );
    var jsonResponse = json.decode(response.body);
    print(jsonResponse['status']);
    if (_mounted) {
      if (jsonResponse['status'] == 200) {
        setState(() {
          currentPinTheme = succesPinTheme; // Set success theme
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login Successful\nPhone: ${widget.phone}\nPassword: ${widget.password}',
            ),
          ),
        );

        // Navigate after 3 seconds
        Future.delayed(Duration(seconds: 1), () {
          if (_mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpSuccessPage()),
            );
          }
        });
      } else {
        setState(() {
          currentPinTheme = errorPinTheme; // Set error theme
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${jsonResponse['message']}')),
        );
      }
    }
  }

  String maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length >= 11) {
      return phoneNumber.replaceRange(4, 10, '******');
    }
    return phoneNumber;
  }

  final errorPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final succesPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.green),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final followPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(126, 126, 126, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          width: double.infinity,
          height: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/sms_verify.png'),
                ],
              ),
              Text(
                'Sms ni tasdiqlash',
                style: AppStyle.fontStyle
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Biz sizga 6 tali raqam jo‘natdik',
                style: AppStyle.fontStyle.copyWith(color: Colors.grey),
              ),
              Text(
                maskPhoneNumber('${widget.phone}'),
                style: AppStyle.fontStyle
                    .copyWith(color: AppColors.lightIconGuardColor),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Tasdiqlash kodini kiriting',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Pinput(
                defaultPinTheme: currentPinTheme, // Use current theme
                errorPinTheme: errorPinTheme,
                followingPinTheme: followPinTheme,
                // onSubmitted: (value) {
                //   _checkStatus();
                //   _verifyCode();
                // },
                onChanged: (value) {
                  currentPinTheme = defaultPinTheme;
                },

                onCompleted: (value) {
                  _checkStatus();
                  _verifyCode();
                },
                length: 6,
                animationCurve: Curves.fastLinearToSlowEaseIn,
                controller: _smsController,
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _verifyCode : null,
                  child: Text(
                    'Akkauntni tasdiqlash va yaratish',
                    style: AppStyle.fontStyle
                        .copyWith(color: AppColors.lightHeaderColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightIconGuardColor,
                    // side: BorderSide(color: AppColors.lightIconGuardColor),
                    elevation: 5,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
