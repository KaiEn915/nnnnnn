
import 'package:gan/services/AuthService.dart';

class HomePostManager {

  /// Creates a new post with the given data.
  static Future<void> createPost({
    required String description,
    required String userId,
    required String username,
    required String imageUrl,
    required String location,
  }) async {

    final postData = {
      "description": description,
      "userId": userId,
      "username": username,
      "imageUrl": imageUrl,
      "location": location,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };
    print(postData );
    await AuthService.db.collection("posts").add(postData);
  }
}
