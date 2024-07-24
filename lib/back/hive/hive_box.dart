import 'package:hive/hive.dart';
import 'package:qoriqlash_xizmati/back/hive/favorite_model.dart';

abstract final class HiveBox {
  static final Box<UsersModel> favotiresBox = Hive.box<UsersModel>('FAVORITES');
}
