import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel {
  @HiveField(0)
  final bool userAuth;
  const FavoriteModel({required this.userAuth});
}
