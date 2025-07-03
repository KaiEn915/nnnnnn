import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/pages/GroupChatRoom.dart';
import 'package:gan/pages/Login.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static Map<String, dynamic>? userData = {};

  static var uid;

  static Future<UserCredential?> loginOrSignUpWithGoogle(
    BuildContext context,
  ) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Fluttertoast.showToast(
          msg: "Google Sign-In cancelled.",
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await createUserData(userCredential, context);
      }

      Fluttertoast.showToast(
        msg: "Google Login success as ${_auth.currentUser?.email}!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );

      Navigator.pushReplacementNamed(context, '/Home');

      return userCredential;
    } catch (error) {
      print("Google Sign-In Error: $error");
      Fluttertoast.showToast(
        msg: "Google Sign-In failed. Please try again.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      return null;
    }
  }

  static Future<void> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please complete your credentials!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Fluttertoast.showToast(
        msg: "Login success as ${_auth.currentUser?.email}!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );

      Navigator.pushReplacementNamed(context, '/Home');
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        Fluttertoast.showToast(
          msg: "Wrong email or password!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        Fluttertoast.showToast(
          msg: "$e",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  static Future<void> createAccountWithEmailAndPassword(
    String email,
    String password,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (password != confirmPassword) {
      Fluttertoast.showToast(
        msg: "Passwords do not match!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await createUserData(credential, context);

      Fluttertoast.showToast(
        msg: "Account created successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login(email: email)),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "Password is too weak!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "This email is already in use.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: "Invalid email format.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> createUserData(
    UserCredential userCredential,
    BuildContext context,
  ) async {
    User? user = userCredential.user;
    if (user != null) {
      String? username = await promptForUsername(context);
      if (username == null || username.trim().isEmpty) {
        print("Username was not provided.");
        return;
      }

      Position? position;
      try {
        position = await MapService.determinePosition();
      } catch (e) {
        Fluttertoast.showToast(msg: "Location permission required.");
        return;
      }

      GeoPoint locationCoordinates = GeoPoint(
        position.latitude,
        position.longitude,
      );

      Map<String, dynamic> userData = {
        "username": username,
        "email": user.email,
        "createdAt": DateTime.now().toIso8601String(),
        "phoneNumber": user.phoneNumber ?? "",
        "locationCoordinates": locationCoordinates,
        "uid":user.uid,
      };

      try {
        print("Saving user data to Firestore...");
        await db.collection("users").doc(user.uid).set(userData);
        print("User data saved successfully.");
      } catch (e) {
        print("Failed to create user data: $e");
      }
    }
  }

  static Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await db
          .collection("users")
          .doc(uid)
          .get();
      if (doc.exists) {
        print(doc);
        return doc.data();
      } else {
        print('not exists');
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  static Future<void> updateUserData() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await db
          .collection("users")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        userData = doc.data();
        Fluttertoast.showToast(msg: "User data is updated!!!");
      } else {
        print('not exists');
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  static Future<String?> promptForUsername(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Username"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Username"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

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
    await AuthService.joinGroupChat(context, ref.id);

    return ref.id;
  }

  static Future<void> joinGroupChat(BuildContext context, String groupChatId) async {
    await db.collection("users").doc(uid).update({
      "groupChats": FieldValue.arrayUnion([groupChatId]),
    });
    await db.collection("groupChats").doc(groupChatId).update({
      "members_uid": FieldValue.arrayUnion([uid]),
    });
    Fluttertoast.showToast(msg: "You have joined group chat $groupChatId");
    updateUserData();
    NavigatorService.openPage(GroupChatRoom(id: groupChatId), context, true);
  }
  static Future<void> quitGroupChat(BuildContext context, String groupChatId) async {
    await db.collection('users').doc(uid).update({"groupChats": FieldValue.arrayRemove([groupChatId])});
    await db.collection('groupChats').doc(groupChatId).update({"members_uid": FieldValue.arrayRemove([uid])});
    NavigatorService.openPage(GroupChat(), context, true);
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

          await postRef.update({"groupChatId": groupChatId});
        }
      }
    }
  }

  static Future<void> deleteGroupChat(BuildContext context,String groupChatId) async {
    final groupDoc = await db.collection('groupChats').doc(groupChatId).get();

    if (!groupDoc.exists) return;

    // Step 1: Get list of user UIDs from the group
    final data = groupDoc.data();
    final List<dynamic> memberUids = data?['members_uid'] ?? [];

    // Step 2: For each user, remove the groupChatId from their activeGroupChats
    final batch = db.batch();

    for (var uid in memberUids) {
      final userRef = db.collection('users').doc(uid);
      batch.update(userRef, {
        'groupChats': FieldValue.arrayRemove([groupChatId])
      });
    }

    // Step 3: Delete the group chat document
    final groupRef = db.collection('groupChats').doc(groupChatId);
    batch.delete(groupRef);

    // Step 4: Commit batch
    await batch.commit();

    Navigator.pushReplacementNamed(context, "/Home");
  }

}
