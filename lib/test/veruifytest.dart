// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_ml_vision/google_ml_vision.dart';
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'package:qoriqlash_xizmati/back/hive/notes_data.dart';

// class UploadPhotoScreen extends StatefulWidget {
//   @override
//   _UploadPhotoScreenState createState() => _UploadPhotoScreenState();
// }

// class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
//   CameraController? _controller;
//   late List<CameraDescription> cameras;
//   bool _isSmiling = false;
//   bool _isBlinking = false;

//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//   }

//   Future<void> _initCamera() async {
//     cameras = await availableCameras();
//     _controller = CameraController(
//       cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.front),
//       ResolutionPreset.high,
//     );
//     await _controller!.initialize();
//     if (!mounted) {
//       return;
//     }
//     setState(() {});
//   }

//   Future<void> _takePictureAndCheckLiveness() async {
//     if (!_controller!.value.isInitialized) {
//       return;
//     }

//     final image = await _controller!.takePicture();
//     final visionImage = GoogleVisionImage.fromFile(File(image.path));
//     final faceDetector = GoogleVision.instance.faceDetector(
//       FaceDetectorOptions(
//         enableClassification: true,
//         mode: FaceDetectorMode.accurate,
//       ),
//     );

//     final faces = await faceDetector.processImage(visionImage);

//     if (faces.isNotEmpty) {
//       final face = faces.first;
//       setState(() {
//         _isSmiling =
//             face.smilingProbability != null && face.smilingProbability! > 0.5;
//         _isBlinking = (face.leftEyeOpenProbability != null &&
//                 face.leftEyeOpenProbability! < 0.4) ||
//             (face.rightEyeOpenProbability != null &&
//                 face.rightEyeOpenProbability! < 0.4);
//       });

//       if (_isSmiling && _isBlinking) {
//         // Если проверка успешна, отправляем изображение
//         _uploadImage(image);
//       } else {
//         print('Liveness check failed: Not smiling or blinking.');
//       }
//     } else {
//       setState(() {
//         _isSmiling = false;
//         _isBlinking = false;
//       });
//       print('No face detected.');
//     }
//   }

//   Future<void> _uploadImage(XFile image) async {
//     final box = Hive.box<NotesData>('notes');
//     String? token = box.getAt(0)?.userToken;

//     if (token != null) {
//       final uri =
//           Uri.parse('http://10.100.9.145:7684/api/v1/user/upload-photo/');
//       final request = http.MultipartRequest('POST', uri)
//         ..headers['Authorization'] = 'Bearer $token'
//         ..files.add(await http.MultipartFile.fromPath('file', image.path));

//       final response = await request.send();

//       if (response.statusCode == 200) {
//         print('Image uploaded successfully');
//       } else {
//         print('Failed to upload image');
//       }
//     } else {
//       print('Token is missing');
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_controller == null || !_controller!.value.isInitialized) {
//       return Center(child: CircularProgressIndicator());
//     }
//     return Scaffold(
//       appBar: AppBar(title: Text('Upload Photo')),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 400,
//             width: double.infinity,
//             child: AspectRatio(
//               aspectRatio: _controller!.value.aspectRatio,
//               child: CameraPreview(_controller!),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _takePictureAndCheckLiveness,
//             child: Text('Capture, Check, and Upload'),
//           ),
//           Text(
//             _isSmiling ? 'Smiling' : 'Not Smiling',
//             style: TextStyle(
//                 fontSize: 20, color: _isSmiling ? Colors.green : Colors.red),
//           ),
//           Text(
//             _isBlinking ? 'Blinking' : 'Not Blinking',
//             style: TextStyle(
//                 fontSize: 20, color: _isBlinking ? Colors.green : Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
