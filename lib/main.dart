// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:qoriqlash_xizmati/front/components/changeColorProvider.dart';
// import 'package:qoriqlash_xizmati/qoriqlash_xizmati_app.dart';

// Future<void> main() async {
//   await Hive.initFlutter();
//   await Hive.openBox<bool>('userBox');

//   WidgetsFlutterBinding.ensureInitialized();

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.transparent,
//     ),
//   );
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => AppDataProvider(),
//       child: QoriqlashXizmatiApp(),
//     ),
//   );
// }
import 'package:biopassid_face_sdk/biopassid_face_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void takeFace() async {
    final config = FaceConfig(licenseKey: 'your-license-key');
    // If you want to use Liveness, uncomment this line
    // config.liveness.enabled = true;
    final controller = FaceController();
    await controller.takeFace(
      config: config,
      onFaceCapture: (face, faceAttributes /* Only available on Liveness */) {
        print('onFaceCapture: ${face.first}');
        // Only available on Liveness
        print('onFaceCapture: $faceAttributes');
      },
      // Only available on Liveness
      onFaceDetected: (faceAttributes) {
        print('onFaceDetected: $faceAttributes');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: takeFace,
          child: const Text('Capture Face'),
        ),
      ),
    );
  }
}
