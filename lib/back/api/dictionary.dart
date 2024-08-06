// import 'dart:convert';
// import 'dart:io';

// Future<Map<String, String>> fetchTranslations(int type) async {
//   String fileName;

//   switch (type) {
//     case 1:
//       fileName = 'ru.json';
//       break;
//     case 2:
//       fileName = 'uzlat.json';
//       break;
//     case 3:
//       fileName = 'uzkiril.json';
//       break;
//     default:
//       throw Exception('Invalid type');
//   }

//   try {
//     final file = File(fileName);
//     final contents = await file.readAsString();

//     final data = json.decode(contents)['data'];
//     Map<String, String> translations = {};

//     for (var item in data) {
//       translations.addAll(Map<String, String>.from(item));
//     }

//     return translations;
//   } catch (e) {
//     throw Exception('Failed to load translations: $e');
//   }
// }
