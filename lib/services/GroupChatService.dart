import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/services/NotificationService.dart';

class GroupChatService{

  static Future<String> createGroupChat(
      String post_id,
      String title,
      String imageData,
      String description,
      ) async {
    final data = {
      "owner_uid": AuthService.uid,
      "members_uid": [AuthService.uid],
      "post_id": post_id,
      "imageData": imageData,
      "title": title,
      "description": description,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };

    final ref = await AuthService.db.collection('groupChats').add(data);
    await ref.update({"id": ref.id});
    Fluttertoast.showToast(msg: "Group chat created successfully");
    await joinGroupChat(ref.id);

    return ref.id;
  }

  static Future<void> joinGroupChat(String groupChatId) async {
    final ref=await AuthService.db.collection("posts").doc(groupChatId).get();
    final snapshot=ref.data();
    final members = snapshot?['members_uid'] as List<dynamic>? ?? [];
    final memberCount = members.length;

    if (memberCount>=100){
      Fluttertoast.showToast(msg: "Join failed, the group chat is fulled");
      return;
    }


    await AuthService.userDocRef.update({
      "activeGroupChats_id": FieldValue.arrayUnion([groupChatId]),
    });
    await AuthService.db.collection("groupChats").doc(groupChatId).update({
      "members_uid": FieldValue.arrayUnion([AuthService.uid]),
    });
    Fluttertoast.showToast(msg: "You have joined group chat $groupChatId");

    // subscribe to topic for group notification
    await FirebaseMessaging.instance.subscribeToTopic(groupChatId);

  }
  static Future<void> quitGroupChat(String groupChatId) async {
    final groupChatRef=AuthService.db.collection('groupChats').doc(groupChatId);


    // remove this group chat id from user's active group chat ids
    await AuthService.userDocRef.update({"activeGroupChats_id": FieldValue.arrayRemove([groupChatId])});
    // remove member uid from group members uid
    groupChatRef.update({"members_uid": FieldValue.arrayRemove([AuthService.uid])});

    // unsubscribe from topic for group notification
    await FirebaseMessaging.instance.unsubscribeFromTopic(groupChatId);
  }

  static Future<void> promptForCreateGroupChat(
      String forPostId,
      ) async {
    final result = await showDialog<bool>(
      context: NavigatorService.navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Group Chat"),
          content: Text("Do you want to create a group chat for this post?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final postRef = AuthService.db.collection('posts').doc(forPostId);
      final docSnap = await postRef.get();

      if (docSnap.exists) {
        Map<String, dynamic>? snapshot = docSnap.data();
        if (snapshot != null) {
          String groupChatId = await createGroupChat(
            snapshot['id'], // assuming the post has its own 'id' field
            "${snapshot['title']}'s Group Chat",
            snapshot['imageData'],
            snapshot['description'],
          );

          await postRef.update({"groupChat_id": groupChatId});
        }
      }
    }
  }

  static Future<void> deleteGroupChat(String groupChatId) async {
    final groupDoc = await AuthService.db.collection('groupChats').doc(groupChatId).get();

    if (!groupDoc.exists) return;

    // Step 1: Get list of user UIDs from the group
    final data = groupDoc.data();
    final List<dynamic> memberUids = data?['members_uid'] ?? [];

    // Step 2: For each user, remove the groupChatId from their activeGroupChats
    final batch = AuthService.db.batch();

    for (var uid in memberUids) {
      final userRef = AuthService.db.collection('users').doc(uid);
      batch.update(userRef, {
        'activeGroupChats_id': FieldValue.arrayRemove([groupChatId])
      });
    }
    // remove linked group chat id from its linked post
    print(data?['post_id']);
    await AuthService.db.collection("posts").doc(data?['post_id']).update({"groupChat_id":""});

    // Step 3: Delete the group chat document
    final groupRef = AuthService.db.collection('groupChats').doc(groupChatId);
    batch.delete(groupRef);


    await batch.commit();
  }
  static Future<void> saveMessageTo(DocumentReference groupChatRef, String content, bool isImageMessage)async{
    final postChat = {
      "content": content,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "owner_uid": AuthService.uid,
      "isImageMessage": isImageMessage,
    };

    await groupChatRef.collection('messages').add(postChat);

    final groupChatSnapshot=await groupChatRef.get();
    final groupChatData=groupChatSnapshot.data() as Map<String,dynamic>;

    NotificationService.sendTopicNotification(groupChatRef.id, groupChatData['title'], "New group chat message received!");

  }


  static Future<void> deleteMessageFrom(DocumentReference groupChatRef, String messageID) async {
    await groupChatRef
        .collection("messages")
        .doc(messageID)
        .delete();
  }

}