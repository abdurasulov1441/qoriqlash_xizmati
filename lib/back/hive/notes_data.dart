import 'package:hive/hive.dart';

part 'notes_data.g.dart';

@HiveType(typeId: 0)
class NotesData {
  @HiveField(0)
  bool isChecked;

  @HiveField(1)
  String userToken;

  NotesData({
    this.isChecked = false,
    this.userToken = '',
  });

  factory NotesData.fromJson(Map<String, dynamic> json) {
    return NotesData(
      isChecked: true, // Setting status to true when token is received
      userToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isChecked': isChecked,
      'userToken': userToken,
    };
  }
}
