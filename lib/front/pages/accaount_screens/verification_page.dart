import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_photo_detector/m7_livelyness_detection.dart';

class M7ExampleScreen extends StatefulWidget {
  const M7ExampleScreen({super.key});

  @override
  State<M7ExampleScreen> createState() => _M7ExampleScreenState();
}

class _M7ExampleScreenState extends State<M7ExampleScreen> {
  //* MARK: - Private Variables
  //? =========================================================
  String? _capturedImagePath;
  bool _isLoading = false;
  bool _startWithInfo = true;
  bool _allowAfterTimeOut = false;
  final List<M7LivelynessStepItem> _verificationSteps = [];
  int _timeOutDuration = 30;

  //* MARK: - Life Cycle Methods
  //? =========================================================
  @override
  void initState() {
    _initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //* MARK: - Private Methods for Business Logic
  //? =========================================================
  void _initValues() {
    _verificationSteps.addAll(
      [
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
      ],
    );
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
        startWithInfoScreen: _startWithInfo,
        maxSecToDetect: _timeOutDuration == 100 ? 2500 : _timeOutDuration,
        allowAfterMaxSec: _allowAfterTimeOut,
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
    setState(() => _isLoading = true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.100.9.145:7684/api/vi/user/'),
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
      setState(() => _isLoading = false);
    }
  }

  String _getTitle(M7LivelynessStep step) {
    switch (step) {
      case M7LivelynessStep.motion:
        return "Motion";
      case M7LivelynessStep.blink:
        return "Blink";
      case M7LivelynessStep.turnLeft:
        return "Turn Your Head Left";
      case M7LivelynessStep.turnRight:
        return "Turn Your Head Right";
      case M7LivelynessStep.smile:
        return "Smile";
    }
  }

  String _getSubTitle(M7LivelynessStep step) {
    switch (step) {
      case M7LivelynessStep.motion:
        return "Detects motion on the face visible in camera";
      case M7LivelynessStep.blink:
        return "Detects Blink on the face visible in camera";
      case M7LivelynessStep.turnLeft:
        return "Detects Left Turn of the on the face visible in camera";
      case M7LivelynessStep.turnRight:
        return "Detects Right Turn of the on the face visible in camera";
      case M7LivelynessStep.smile:
        return "Detects Smile on the face visible in camera";
    }
  }

  bool _isSelected(M7LivelynessStep step) {
    final M7LivelynessStepItem? doesExist = _verificationSteps.firstWhereOrNull(
      (p0) => p0.step == step,
    );
    return doesExist != null;
  }

  void _onStepValChanged(M7LivelynessStep step, bool value) {
    if (!value && _verificationSteps.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Need to have at least 1 step of verification",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.red.shade900,
        ),
      );
      return;
    }
    final M7LivelynessStepItem? doesExist = _verificationSteps.firstWhereOrNull(
      (p0) => p0.step == step,
    );

    if (doesExist == null && value) {
      _verificationSteps.add(
        M7LivelynessStepItem(
          step: step,
          title: _getTitle(step),
          isCompleted: false,
        ),
      );
    } else {
      if (!value) {
        _verificationSteps.removeWhere((p0) => p0.step == step);
      }
    }
    setState(() {});
  }

  //* MARK: - Private Methods for UI Components
  //? =========================================================
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("M7 Livelyness Detection"),
    );
  }

  Widget _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildContent(),
        Visibility(
          visible: _isLoading,
          child: const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: const Text(
              "Detect Livelyness",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 3),
            const Text(
              "Start with info screen:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            CupertinoSwitch(
              value: _startWithInfo,
              onChanged: (value) => setState(() => _startWithInfo = value),
            ),
            const Spacer(flex: 3),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 3),
            const Text(
              "Allow after timer is completed:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            CupertinoSwitch(
              value: _allowAfterTimeOut,
              onChanged: (value) => setState(() => _allowAfterTimeOut = value),
            ),
            const Spacer(flex: 3),
          ],
        ),
        const Spacer(),
        Text(
          "Detection Time-out Duration (In Seconds): ${_timeOutDuration == 100 ? "No Limit" : _timeOutDuration}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Slider(
          min: 0,
          max: 100,
          value: _timeOutDuration.toDouble(),
          onChanged: (value) =>
              setState(() => _timeOutDuration = value.toInt()),
        ),
        Expanded(
          flex: 14,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: M7LivelynessStep.values.length,
            itemBuilder: (context, index) => ExpansionTile(
              title: Text(
                _getTitle(M7LivelynessStep.values[index]),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              children: [
                ListTile(
                  title: Text(
                    _getSubTitle(M7LivelynessStep.values[index]),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  trailing: CupertinoSwitch(
                    value: _isSelected(M7LivelynessStep.values[index]),
                    onChanged: (value) => _onStepValChanged(
                        M7LivelynessStep.values[index], value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
