import 'package:camera/camera.dart';
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
}