import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qoriqlash_xizmati/back/hive/favorite_model.dart';

import 'package:qoriqlash_xizmati/qoriqlash_xizmati_app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.initFlutter();

  await Hive.openBox<UsersModel>('userstate');
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(QoriqlashXizmatiApp());
}
