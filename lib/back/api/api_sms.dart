import 'dart:convert';
import 'package:http/http.dart' as http;

class SmsService {
  final String login = 'Qoriqlash';
  final String password = 'WNM63NWR7C6VwwT98RG7';
  final String url = 'https://appdata.uz/sms_proxy.php';

  Future<void> sendSms(List<Map<String, String>> messages) async {
    final data = {
      'login': login,
      'password': password,
      'data': jsonEncode(messages),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: data,
    );

    if (response.statusCode == 200) {
      print('SMS sent successfully: ${response.body}');
    } else {
      print('Failed to send SMS: ${response.body}');
    }
  }
}
