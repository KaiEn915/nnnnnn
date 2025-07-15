import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/NavigatorService.dart';

class GroupChatService{

  static Future<String> createGroupChat(
      BuildContext context,
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
    }
    else{
      await AuthService.userDocRef.update({
        "activeGroupChats_id": FieldValue.arrayUnion([groupChatId]),
      });
      await AuthService.db.collection("groupChats").doc(groupChatId).update({
        "members_uid": FieldValue.arrayUnion([AuthService.uid]),
      });
      Fluttertoast.showToast(msg: "You have joined group chat $groupChatId");
    }


  }
  static Future<void> quitGroupChat(String groupChatId) async {
    final groupChatRef=AuthService.db.collection('groupChats').doc(groupChatId);


    // remove this group chat id from user's active group chat ids
    await AuthService.userDocRef.update({"activeGroupChats_id": FieldValue.arrayRemove([groupChatId])});
    // remove member uid from group members uid
    groupChatRef.update({"members_uid": FieldValue.arrayRemove([AuthService.uid])});
  }

  static Future<void> promptForCreateGroupChat(
      BuildContext context,
      String forPostId,
      ) async {
    final result = await showDialog<bool>(
      context: context,
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
            context,
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
  static Future<void> saveMessageTo({
    required DocumentReference groupChatRef,
    required String content,
    bool isImageMessage = false,
  }) async {
    final postChat = {
      "content": content,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "owner_uid": AuthService.uid,
      "isImageMessage": isImageMessage,
    };

    await groupChatRef.collection('messages').add(postChat);
  }
  static Future<void> deleteMessageFrom(DocumentReference groupChatRef, String messageID) async {
    await groupChatRef
        .collection("messages")
        .doc(messageID)
        .delete();
  }

}