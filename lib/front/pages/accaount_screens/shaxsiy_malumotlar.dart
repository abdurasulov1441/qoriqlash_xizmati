import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';
import 'package:http/http.dart' as http;

class ShaxsiyMalumotlar extends StatefulWidget {
  const ShaxsiyMalumotlar({super.key});

  @override
  State<ShaxsiyMalumotlar> createState() => _ShaxsiyMalumotlarState();
}

class _ShaxsiyMalumotlarState extends State<ShaxsiyMalumotlar> {
  String fullName = 'Raximov Voris Avazbek o\'g\'li'; // Default name
  String phoneNumber = '+998 (99) 786-25-51'; // Default phone number
  String passportSeriesAndNumber =
      'AA 1234567'; // Default passport series and number
  String passportGivenDate = '15.02.2018'; // Default passport given date
  String passportGivenBy =
      'Toshkent viloyati Qibray tumani'; // Default passport given by
  String jshshir = '12 34 56 78 90 12 34'; // Default JSHSHIR
  String address =
      'Toshkent vil. M.Ulug’bek tum. A.Temur MFY'; // Default address

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Create an instance of FlutterSecureStorage
    final storage = FlutterSecureStorage();

    // Retrieve the token from secure storage
    String? token = await storage.read(key: 'accessToken');

    if (token != null) {
      final response = await http.get(
        Uri.parse('${AppConfig.serverAddress}/api/v1/user/info'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          fullName =
              '${data['surname']} ${data['first_name']} ${data['last_name']}'; //first_name  last_name surname
          phoneNumber = data['phone_number'];
          passportSeriesAndNumber =
              '${data['passport_series']} ${data['passport_number']}';
          passportGivenDate = data['given_date'];
          passportGivenBy = data['given_by'];
          jshshir = '12 34 56 78 90 12 34';
          address = 'Toshkent vil. M.Ulug’bek tum. A.Temur MFY';
        });
      } else {
        // Handle error
        print('Failed to fetch user data');
      }
    } else {
      // Handle the case where token is not available
      print('Token not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightHeaderColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Shaxsiy Ma\'lumotlar'),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              child: Image.asset('assets/images/person.png'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildStaticField('F.I.SH', fullName),
                  buildStaticField('Telefon raqam', phoneNumber),
                  buildStaticField(
                      'Passport seriyasi va raqami', passportSeriesAndNumber),
                  buildStaticField('Passport berilgan sana', passportGivenDate),
                  buildStaticField(
                      'Passport kim tomonidan berilgan', passportGivenBy),
                  buildStaticField('JSHSHIR', jshshir),
                  buildStaticField('Manzil', address),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget buildStaticField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            Text(
              label,
              style: AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.fillColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: AppColors.lightIconGuardColor),
                ),
                child: Text(
                  value,
                  style: AppStyle.fontStyle
                      .copyWith(color: AppColors.lightTextColor),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
