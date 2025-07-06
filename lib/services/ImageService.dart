import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:image_picker/image_picker.dart';

class ImageService{
  static Future<XFile?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      Fluttertoast.showToast(msg: "Pick an image");
      final XFile? image = await picker.pickImage(source: source);
      return image;

    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  static Widget tryDisplayImage(String? imageData, {
    double? width=100,
    double? height=100,
    BoxFit fit = BoxFit.cover,
  }) {
    if (imageData == null || imageData.isEmpty) {
      return Icon(Icons.broken_image, size: width ?? 100, color: Colors.grey);
    }

    try {
      Uint8List bytes = base64Decode(imageData);
      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: fit,
      );
    } catch (e) {
      return Icon(Icons.broken_image, size: width ?? 100, color: Colors.red);
    }
  }
  
  static Future<void> saveImage(String imageData)async{
    Fluttertoast.showToast(msg: "Saving images...");

    Fluttertoast.showToast(msg: "Image not saved, save later!");
  }

}