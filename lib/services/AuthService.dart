import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/Home.dart';
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
  static DocumentReference<Map<String,dynamic>> userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

  static var uid;

  static Future<UserCredential?> loginOrSignUpWithGoogle() async {
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
        await createUserData(userCredential);
      }

      Fluttertoast.showToast(
        msg: "Google Login success as ${_auth.currentUser?.email}!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );

      await loginSuccess(userCredential.user!.uid);

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

      await loginSuccess(_auth.currentUser!.uid);
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

      await createUserData(credential);

      Fluttertoast.showToast(
        msg: "Account created successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      NavigatorService.openPage(Login(email: email), true);
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
    UserCredential userCredential
  ) async {
    User? user = userCredential.user;
    if (user != null) {
      String? username = await promptForUsername();
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
        "rewardPoints":0,
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

  static Future<String?> promptForUsername() async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: NavigatorService.navigatorKey.currentState!.context,
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

  static Future loginSuccess(String withUid)async{
    uid=withUid;
    userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // refresh fcm token for notification
    String? token=await FirebaseMessaging.instance.getToken();
    userDocRef.update({"fcmToken":token});
    
    
    // regularly keep tracks of user online or offline
    Timer.periodic(Duration(seconds: 5), (timer) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'lastUpdated': FieldValue.serverTimestamp()});
    });
    NavigatorService.openPage(Home(), true);
  }

  static Future<bool> isOnline(String uid) async {
    final snapshot = await db.collection("users").doc(uid).get();
    final data = snapshot.data();

    if (data == null || data['lastUpdated'] == null) {
      return false;
    }

    final Timestamp lastUpdated = data['lastUpdated'];
    final DateTime lastOnline = lastUpdated.toDate();
    final Duration diff = DateTime.now().difference(lastOnline);

    final bool isOnline=diff.inMinutes<=1;
    print("User $uid is ${isOnline?"Online":"Offline"}!");

    return isOnline;
  }
  static bool isPhoneNumberValid(String phoneNumber) {
    phoneNumber = phoneNumber.trim();

    return RegExp(r'^0\d{8,10}$').hasMatch(phoneNumber);
  }

}
