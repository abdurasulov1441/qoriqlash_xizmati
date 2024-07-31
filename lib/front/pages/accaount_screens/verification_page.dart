import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_photo_detector/m7_livelyness_detection.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';

class M7ExampleScreen extends StatefulWidget {
  const M7ExampleScreen({super.key});

  @override
  State<M7ExampleScreen> createState() => _M7ExampleScreenState();
}

class _M7ExampleScreenState extends State<M7ExampleScreen> {
  String? _capturedImagePath;
  // bool _isLoading = false;
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

  void _sendImageToServer(String imagePath) async {
    // setState(() => _isLoading = true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.100.9.145:7684/api/vi/user/'),
        //  Uri.parse('http://84.54.96.157:17041/api/vi/user/'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Image uploaded successfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
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
      //setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.min,
        children: [
          MiniRedAppBar(),
          MiniRedTitle(title: 'Kabinet'),
          //   const Spacer(flex: 4),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                "Shaxsni tasdiqlash",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          //  const Spacer(),
        ],
      ),
      // Visibility(
      //   visible: _isLoading,
      //   child: const Center(child: CircularProgressIndicator.adaptive()),
      // ),
    );
  }
}
