import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/GroupChatService.dart';
class PostService{
  static Future<void> createPost({
    required String title,
    required Uint8List imageData,
    required String description,
    required String uid,
    required String breed,
    required GeoPoint? locationCoordinates,
  }) async {
    final postData = {
      "title": title,
      "description": description,
      "owner_uid": uid,
      "imageData": base64Encode(imageData),
      "locationCoordinates": locationCoordinates,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "breed": breed,
    };
    final postRef = await AuthService.db.collection("posts").add(postData);
    await postRef.update({"id": postRef.id});

    await GroupChatService.promptForCreateGroupChat(postRef.id);


  }
  static Future<void> deletePost(String id) async {
    final ref=AuthService.db.collection("posts").doc(id);
    final snapshot=await ref.get();
    final data=snapshot.data();

    // delete linked group chat
    await GroupChatService.deleteGroupChat(data?['groupChat_id']);
    Fluttertoast.showToast(msg: "Deleted linked group chat");

    // delete post doc
    ref.delete();

    Fluttertoast.showToast(msg: "Post deleted successfully");


  }


  static Future<void> favoritePost(String id)async{
    await AuthService.db.collection("users").doc(AuthService.uid).update({"favoritePosts_id":FieldValue.arrayUnion([id])});
    Fluttertoast.showToast(msg: "Post added to favorite successfully");
  }

  static Future<void> unfavoritePost(String id)async{
    await AuthService.db.collection("users").doc(AuthService.uid).update({"favoritePosts_id":FieldValue.arrayRemove([id])});
    Fluttertoast.showToast(msg: "Post removed from favorite successfully");
  }
}