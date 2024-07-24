import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class UsersModel {
  @HiveField(0)
  final bool userAuth;
  const UsersModel(this.userAuth);
}
