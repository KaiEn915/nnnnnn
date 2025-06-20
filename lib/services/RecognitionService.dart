import 'package:tflite_v2/tflite_v2.dart';

class RecognitionService{
  static Future<List?> recognizeImage(String imagePath) async {
    var recognitions = await Tflite.runModelOnImage(
      path: imagePath,
      imageMean: 127.5,
      // default normalization values
      imageStd: 127.5,
      numResults: 3,
      threshold: 0.5,
      asynch: true,
    );

    return recognitions;
  }
}