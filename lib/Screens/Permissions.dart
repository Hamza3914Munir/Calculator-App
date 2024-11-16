import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {
  // Check and request camera permission with permission denied message
  static Future<bool> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    if (!status.isGranted) {
      _showPermissionDeniedMessage(context, 'Camera');
    }

    return status.isGranted;
  }

  // Check and request gallery permission with permission denied message
  static Future<bool> requestGalleryPermission(BuildContext context) async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.storage.request(); // Use storage for Android
    } else {
      status = await Permission.photos.request(); // Use photos for iOS
    }

    if (!status.isGranted) {
      _showPermissionDeniedMessage(context, 'Gallery');
    }

    return status.isGranted;
  }

  // Check and request microphone permission with permission denied message
  static Future<bool> requestMicrophonePermission(BuildContext context) async {
    PermissionStatus status = await Permission.microphone.status;

    if (status.isDenied) {
      status = await Permission.microphone.request();
    }

    if (!status.isGranted) {
      _showPermissionDeniedMessage(context, 'Microphone');
    }

    return status.isGranted;
  }

  // Show a SnackBar message if permission is denied
  static void _showPermissionDeniedMessage(BuildContext context, String permission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$permission permission is required to use this feature.')),
    );
  }
}
