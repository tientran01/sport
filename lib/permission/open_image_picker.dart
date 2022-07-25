import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sport_app/helper/firebase_helper.dart';

class OpenImagePicker {
  OpenImagePicker._();

  static Future<PermissionStatus> _checkCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    return status;
  }

  static Future<PermissionStatus> _checkLibraryPermission() async {
    PermissionStatus status = await Permission.photos.request();
    return status;
  }

  static Future<void> getImage({
    bool getImageFromCamera = false,
    ValueChanged<String>? value,
  }) async {
    if (getImageFromCamera) {
      _checkCameraPermission().then((status) async {
        if (status == PermissionStatus.granted) {
          final pickerFileCamera = await ImagePicker().pickImage(
            source: ImageSource.camera,
          );
          final fileName = File(pickerFileCamera?.path ?? "");
          final destination = 'files/$fileName';
          FirebaseHelper.shared.uploadImageFile(destination, fileName);
          if (pickerFileCamera != null) {
            value!(pickerFileCamera.path);
          }
        }
      });
    } else {
      _checkLibraryPermission().then((status) async {
        if (status == PermissionStatus.granted) {
          final pickerFileCamera = await ImagePicker().pickImage(
            source: ImageSource.gallery,
          );
          final fileName = File(pickerFileCamera?.path ?? "");
          final destination = 'files/$fileName';
          print("====$destination");
          FirebaseHelper.shared.uploadImageFile(destination, fileName);
          if (pickerFileCamera != null) {
            value!(pickerFileCamera.path);
          }
        }
      });
    }
  }
}
