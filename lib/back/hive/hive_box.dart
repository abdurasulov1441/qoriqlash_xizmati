import 'package:hive/hive.dart';

abstract class HiveBox {
  static final userBox = Hive.box<String>('notes');
}
