import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  bool userAuth;

  FavoriteModel({required this.userAuth});
}
