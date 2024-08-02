import 'package:hive/hive.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs
part 'notes_data.g.dart';

@HiveType(typeId: 0)
class NotesData {
  @HiveField(0)
  String? userRefreshToken;

  @HiveField(1)
  String? userToken;

  NotesData({
    this.userRefreshToken,
    this.userToken,
  });
}
