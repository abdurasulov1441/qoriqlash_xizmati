import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/qoriqlash_xizmati_app.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppDataProvider()..loadLanguage('uzlat'),
      child: QoriqlashXizmatiApp(),
    ),
  );
}

