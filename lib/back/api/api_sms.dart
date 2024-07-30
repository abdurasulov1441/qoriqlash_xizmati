// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<void> registerUser() async {
//  // final url = Uri.parse('http://10.100.9.145:7684/api/v1/auth/register');
//   final headers = {"Content-Type": "application/json"};
//   final body =
//       jsonEncode({"password": "password", "phone_number": "+998911456070"});

//   try {
//     final response = await http.post(url, headers: headers, body: body);

//     if (response.statusCode == 200) {
//       // Handle successful response
//       print('User registered successfully');
//     } else {
//       // Handle error response
//       print('Failed to register user: ${response.body}');
//     }
//   } catch (e) {
//     // Handle network or other errors
//     print('Error occurred: $e');
//   }
// }
