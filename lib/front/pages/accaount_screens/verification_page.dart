import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:live_photo_detector/index.dart';
import 'package:qoriqlash_xizmati/back/api/appConfig.dart';

import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FaceVirify(),
    );
  }
}

class FaceVirify extends StatefulWidget {
  const FaceVirify({super.key});

  @override
  _FaceVirifyState createState() => _FaceVirifyState();
}

class _FaceVirifyState extends State<FaceVirify> {
  final _passportNumberController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedSeries;
  DateTime? _selectedDate;

  bool _isFormValid = false;

  final List<String> _seriesOptions = [
    'AA',
    'AB',
    'AC',
    'AD',
    'AE',
    'AF',
    'AG',
    'AH',
    'AI',
    'AJ',
    'AK',
  ];

  @override
  void initState() {
    super.initState();

    // Listen to changes in the form fields
    _passportNumberController.addListener(_validateForm);
    _dateController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _passportNumberController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Validate form to enable or disable the button
  void _validateForm() {
    setState(() {
      _isFormValid = _selectedSeries != null &&
          _passportNumberController.text.length == 7 &&
          _selectedDate != null;
    });
  }

  Future<void> _submitData() async {
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
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://10.100.9.145:7684/api/v1/user/passport-data'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: {
          'series': _selectedSeries,
          'number': _passportNumberController.text,
          'birthdate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Data submitted successfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to submit data.",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MiniRedAppBar(),
          const Padding(
            padding: EdgeInsets.all(0),
            child: MiniRedTitle(title: 'Kabinet'),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Passport Series Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedSeries,
                  hint: const Text('Выберите серию паспорта'),
                  items: _seriesOptions.map((series) {
                    return DropdownMenuItem<String>(
                      value: series,
                      child: Text(series),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSeries = value;
                      _validateForm();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Серия паспорта',
                  ),
                ),
                const SizedBox(height: 10),

                // Passport Number TextField
                TextFormField(
                  controller: _passportNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Номер паспорта',
                  ),
                  inputFormatters: [
                    // Ensure only numeric input
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(7),
                  ],
                ),
                const SizedBox(height: 10),

                // Date of Birth Picker
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Дата рождения',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                        _dateController.text =
                            DateFormat('dd.MM.yyyy').format(pickedDate);
                        _validateForm();
                      });
                    }
                  },
                ),
                const SizedBox(height: 50),

                // Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isFormValid
                        ? () async {
                            await _submitData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => M7ExampleScreen(),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      'Yuzni identifikatsiya qilish',
                      style: AppStyle.fontStyle
                          .copyWith(color: AppColors.lightHeaderColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightIconGuardColor,
                      side: BorderSide(color: AppColors.lightIconGuardColor),
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
      title: "Jilmaying",
      isCompleted: false,
    ),
    M7LivelynessStepItem(
      step: M7LivelynessStep.blink,
      title: "Ko'zni pirpirating",
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
      print(response);
      print('pizdes boldi ${response.statusCode}');
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
        print(response.statusCode);
        print(response.request);
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.min,
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
                replacement: Lottie.asset(
                  'assets/lotties/face.json',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Visibility(
                visible: _capturedImagePath != null,
                child: const Spacer(),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _onStartLivelyness,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightIconGuardColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text(
                    "Identifikatsiyadan o\'tish",
                    style: AppStyle.fontStyle
                        .copyWith(color: AppColors.lightHeaderColor),
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
