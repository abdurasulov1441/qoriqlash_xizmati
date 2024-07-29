import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';
import 'package:qoriqlash_xizmati/front/components/changeColorProvider.dart';
import 'package:qoriqlash_xizmati/qoriqlash_xizmati_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NotesDataAdapter());
  await Hive.openBox<NotesData>('userBox'); // Open 'userBox' here

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
      child: QoriqlashXizmatiApp(),
    ),
  );
}
