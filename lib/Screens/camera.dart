import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class CameraCaptureScreen extends StatefulWidget {
  @override
  _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // Function to request camera permission
  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    return status.isGranted;
  }

  // Function to capture image
  Future<void> _captureImage() async {
    // First, request camera permission
    bool hasPermission = await _requestCameraPermission();

    // If permission is granted, open the camera to capture an image
    if (hasPermission) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _imageFile = image;
        });
      }
    } else {
      // Show a message if permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission is required to capture images')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Capture")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(File(_imageFile!.path)) // Display captured image
                : Text("No image captured"),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 50,
              color: Colors.blue,
              onPressed: _captureImage,
            ),
          ],
        ),
      ),
    );
  }
}
