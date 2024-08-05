import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserStatusService {
  final _storage = const FlutterSecureStorage();
  final _serverUrl = 'http://10.100.9.145:7684/api/v1/user/status';

  Future<int> getUserStatus() async {
    String? token = await _storage.read(key: 'accessToken');

    if (token == null) {
      print('No token found');
      throw Exception('No token found');
    }

    try {
      final response = await http.get(
        Uri.parse(_serverUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Ensure we're accessing 'user_status' inside 'data'
        return data['data']['user_status'];
      } else {
        print('Failed to load user status: ${response.reasonPhrase}');
        throw Exception('Failed to load user status');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching user status');
    }
  }
}
