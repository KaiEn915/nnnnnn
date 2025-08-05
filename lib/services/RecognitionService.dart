import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:tflite_v2/tflite_v2.dart';

class RecognitionService{
  static Future<void> loadCatModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_cat.tflite",
      labels: "assets/labels_cat.txt",
    );
    print("Cat model loaded: $res");
  }
  static Future<void> loadDogModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_dog.tflite",
      labels: "assets/labels_dog.txt",
    );
    print("Dog model loaded: $res");
  }
  static Future<List?> recognizeImage(String imagePath) async {
    Fluttertoast.showToast(msg: "Recognizing...");
    var recognitions = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 5,
      threshold: 0,
      asynch: true,
    );
    Fluttertoast.showToast(msg: "Recognition done!");
    return recognitions;
  }

  static Future<void> promptPetType()async{
    String petType=await showDialog(
      context: NavigatorService.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose a Pet"),
          content: Text("Would you like to select a cat or a dog?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop("Cat");
                print("User chose Cat");
                // Add your action for Cat
              },
              child: Text("Cat"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop("Dog");
                print("User chose Dog");
                // Add your action for Dog
              },
              child: Text("Dog"),
            ),
          ],
        );
      },
    );

    // load model first
    if (petType=="Dog"){
      await RecognitionService.loadDogModel();
      Fluttertoast.showToast(msg: "Dog model loaded");
    }
    else if(petType=="Cat"){
      await RecognitionService.loadCatModel();
      Fluttertoast.showToast(msg: "Cat model loaded");
    }
  }
}