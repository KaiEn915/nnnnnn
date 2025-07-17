import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/TakePicture.dart';


import 'package:image_picker/image_picker.dart';

class ImageService{
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

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


  static Future<void> saveImage(String imageData)async{
    Fluttertoast.showToast(msg: "Saving images...");

    Fluttertoast.showToast(msg: "Image not saved, save later!");
  }

  static Future<XFile> promptPicture(BuildContext context,bool doPopAfterDone)async{
    final result=await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePicture(
          doPopAfterDone: doPopAfterDone,
        ),
      ),
    );

    return result;
  }

  static Widget tryDisplayImage(String imageData, double iconSize){
    return imageData.isEmpty ? Icon(
      Icons.broken_image,
      color: Colors.grey,
      size: iconSize,
    ):Image.memory(base64Decode(imageData));
  }
}