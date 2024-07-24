// import 'dart:ui';
// import 'package:hive/hive.dart';

// part 'users_model.g.dart';

// @HiveType(typeId: 0)
// class UsersModel {
//   @HiveField(0)
//   bool? isDarkTheme;

//   @HiveField(1)
//   bool isUserActive;

//   UsersModel({
//     this.isDarkTheme = false,
//     this.isUserActive = false,
//   });

//   // Color property is not directly supported by Hive.
//   // To store Color, you need to convert it to an integer or string.
//   @HiveField(2)
//   int? colorValue;

//   Color get color => Color(colorValue ?? 0xFFFFFFFF); // Default white color

//   set color(Color color) {
//     colorValue = color.value;
//   }
// }
