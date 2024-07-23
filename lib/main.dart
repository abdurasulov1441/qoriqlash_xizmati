import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qoriqlash_xizmati/qoriqlash_xizmati_app.dart';

Future<void> main() async {
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
