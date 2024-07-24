import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel {
  @HiveField(0)
  final String cityName;
  const FavoriteModel({required this.cityName});
}
