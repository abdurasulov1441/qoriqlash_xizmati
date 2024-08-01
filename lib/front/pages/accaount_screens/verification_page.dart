import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:live_photo_detector/m7_livelyness_detection.dart';
import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:hive/hive.dart';

class M7ExampleScreen extends StatefulWidget {
  const M7ExampleScreen({super.key});

  @override
  State<M7ExampleScreen> createState() => _M7ExampleScreenState();
}

class _M7ExampleScreenState extends State<M7ExampleScreen> {
  String? _capturedImagePath;
  String? _passportSeries;
  String? _passportNumber;
  DateTime? _birthDate;

  final List<M7LivelynessStepItem> _verificationSteps = [
    M7LivelynessStepItem(
      step: M7LivelynessStep.smile,
      title: "Jilmaying",
      isCompleted: false,
    ),
    M7LivelynessStepItem(
      step: M7LivelynessStep.blink,
      title: "Ko'zingizni yumib oching",
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
    final box = Hive.box<NotesData>('notes');
    String? token = box.getAt(0)?.userToken;

    if (_passportSeries == null ||
        _passportNumber == null ||
        _birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Please fill in all the fields.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.100.9.145:7684/api/v1/user/upload-photo/'),
        //    Uri.parse('http://84.54.96.157:17041/api/v1/user/upload-photo/'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));
      // request.fields['passport_series'] = _passportSeries!;
      //  request.fields['passport_number'] = _passportNumber!;
      // request.fields['birth_date'] = _birthDate!.toIso8601String();
      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Data uploaded successfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessPage()),
        );
      } else {
        print(response.statusCode);
        print(response.statusCode);
        print(response.statusCode);
        print(response.statusCode);

        print(response.statusCode);
        print(response.statusCode);
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "Failed ",
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
    }
  }

  void _showRulesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RulesPage(
          onProceed: () {
            Navigator.pop(context); // Close the rules page
            _onStartLivelyness(); // Start livelyness detection
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MiniRedAppBar(),
          MiniRedTitle(title: 'Kabinet'),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        )),
                    labelText: "Passport Series",
                  ),
                  onChanged: (value) {
                    _passportSeries = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    labelText: "Passport Number",
                  ),
                  onChanged: (value) {
                    _passportNumber = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _birthDate = pickedDate;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: "Birth Date",
                      errorText: _birthDate == null ? "Select a date" : null,
                    ),
                    child: Text(
                      _birthDate == null
                          ? "Select your birth date"
                          : "${_birthDate!.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _showRulesPage,
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
        ],
      ),
    );
  }
}

class RulesPage extends StatelessWidget {
  final VoidCallback onProceed;

  const RulesPage({Key? key, required this.onProceed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Kabinet'),
            Text(
              "Please follow these rules for face verification:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("1. Make sure you are in a well-lit area."),
            SizedBox(height: 5),
            Text("2. Remove any glasses or masks."),
            SizedBox(height: 5),
            Text("3. Keep a neutral expression."),
            SizedBox(height: 5),
            Image.asset('assets/images/face.gif'),
            Text(
                "4. Follow the instructions on the screen (e.g., smile, blink)."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onProceed,
              child: Text("Proceed to Verification"),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Success")),
      body: Center(
        child: Text("Verification successful!"),
      ),
    );
  }
}
