import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'dart:io';

import '../main.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  late int _selectedCameraIndex;
  late String downloadUrl;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: isDarkMode ? Colors.white : Colors.white,
                  child: Icon(Icons.flash_on),
                  onPressed: () => _toggleFlash(),
                ),
                FloatingActionButton(
                  backgroundColor: isDarkMode ? Colors.white : Colors.white,
                  child: Icon(Icons.switch_camera),
                  onPressed: () => _toggleCamera(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                foregroundColor: isDarkMode ? Colors.white : Colors.white,
                backgroundColor: Colors.red,
                child: Icon(_isRecording ? Icons.stop : Icons.circle),
                onPressed: () => _recordVideo(),
              ),
            ),
          ],
        ),
      );
    }
  }

  _initCamera() async {
    final cameras = await availableCameras();
    _selectedCameraIndex = 0;
    _cameraController = CameraController(
      cameras[_selectedCameraIndex],
      ResolutionPreset.medium,
    );
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    _initCamera();
    twilioFlutter = TwilioFlutter(
        //This is our twillo credentials, it must be hidden :)
        accountSid: '******************************',
        authToken: '********************************',
        twilioNumber: '+20***********');
    super.initState();
  }

  Future<void> sendSms(List<String> phoneNumber, String downloadUrl) async {
    phoneNumber.forEach((element) {
      twilioFlutter.sendSMS(
          toNumber: element.toString(),
          messageBody:
              "This is an automated Emergency Message sent to you by ${currentApplicationUser!.username}. he is sending you an emergency Video so You can help him, here is the video Link $downloadUrl");
    });
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      final String videoPath = file.path;
      final String fileName = basename(videoPath);
      final Reference videoRef =
          FirebaseStorage.instance.ref().child('videos/$fileName');
      final UploadTask uploadTask = videoRef.putFile(File(videoPath));
      final TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      List<String> tempList = [];
      for (int i = 0;
          i < currentApplicationUser!.emergencyContacts.length;
          i++) {
        tempList.add(currentApplicationUser!.emergencyContacts[i].phoneNumber);
      }
      print(tempList);
      await sendSms(tempList, downloadUrl);
      setState(() => _isRecording = false);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  _toggleFlash() {
    _cameraController.setFlashMode(
        _cameraController.value.flashMode == FlashMode.off
            ? FlashMode.torch
            : FlashMode.off);
  }

  _toggleCamera() async {
    final cameras = await availableCameras();
    setState(() {
      _selectedCameraIndex = (_selectedCameraIndex + 1) %
          cameras.length; // switch to the other camera
      _cameraController = CameraController(
        cameras[_selectedCameraIndex],
        ResolutionPreset.medium,
      );
      _cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }
}
