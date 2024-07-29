import 'package:hive/hive.dart';
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';

abstract class HiveBox {
  static final notes = Hive.box<NotesData>('notes');
}
