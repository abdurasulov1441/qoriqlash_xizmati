import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:live_photo_detector/m7_livelyness_detection.dart';
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';

class M7ExampleScreen extends StatefulWidget {
  const M7ExampleScreen({super.key});

  @override
  State<M7ExampleScreen> createState() => _M7ExampleScreenState();
}

class _M7ExampleScreenState extends State<M7ExampleScreen> {
  String? _capturedImagePath;
  bool _isLoading = false;
  final List<M7LivelynessStepItem> _verificationSteps = [
    M7LivelynessStepItem(
      step: M7LivelynessStep.smile,
      title: "Smile",
      isCompleted: false,
    ),
    M7LivelynessStepItem(
      step: M7LivelynessStep.blink,
      title: "Blink",
      isCompleted: false,
    ),
  ];
  int _timeOutDuration = 30;

  @override
  void initState() {
    super.initState();
    M7LivelynessDetection.instance.configure(
      contourColor: Colors.white,
      thresholds: [
        M7SmileDetectionThreshold(
          probability: 0.8,
        ),
        M7BlinkDetectionThreshold(
          leftEyeProbability: 0.25,
          rightEyeProbability: 0.25,
        ),
      ],
    );
  }

  void _onStartLivelyness() async {
    setState(() => _capturedImagePath = null);
    final String? response =
        await M7LivelynessDetection.instance.detectLivelyness(
      context,
      config: M7DetectionConfig(
        steps: _verificationSteps,
        maxSecToDetect: _timeOutDuration,
        captureButtonColor: Colors.red,
      ),
    );
    if (response == null) {
      return;
    }
    setState(() => _capturedImagePath = response);

    if (_capturedImagePath != null) {
      _sendImageToServer(_capturedImagePath!);
    }
  }

  Future<void> _sendImageToServer(String imagePath) async {
    setState(() => _isLoading = true);
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Authorization token not found!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };
      print(token);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppConfig.serverAddress}/api/v1/user/upload-photo/'),
      );

      request.headers.addAll(headers);

      // Add the file to the request
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));

      // Send the request
      var response = await request.send();
      print(response.statusCode);

      // Handle the response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Image uploaded successfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to upload image.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("M7 Livelyness Detection"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 4),
              Visibility(
                visible: _capturedImagePath != null,
                child: Expanded(
                  flex: 7,
                  child: Image.file(
                    File(_capturedImagePath ?? ""),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Visibility(
                visible: _capturedImagePath != null,
                child: const Spacer(),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _onStartLivelyness,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    "Identifikatsiyadan o\'tish",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Visibility(
            visible: _isLoading,
            child: const Center(child: CircularProgressIndicator.adaptive()),
          ),
        ],
      ),
    );
  }
}
