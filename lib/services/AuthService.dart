import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/Login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final DatabaseReference  dbRef = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://petfinder-ba6f8-default-rtdb.asia-southeast1.firebasedatabase.app").ref();
  static Map<String,dynamic> userData= {};

  // login methods
  static Future<UserCredential?> loginOrSignUpWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in flow
        Fluttertoast.showToast(
          msg: "Google Sign-In cancelled.",
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        return null;
      }

      // Obtain the auth details from the Google sign-in
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new Firebase credential using the Google tokens
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // After sign-in, create user data in Realtime Database if new user
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await createUserData(userCredential,context);
      }

      // Show success toast
      Fluttertoast.showToast(
        msg: "Google Login success as ${FirebaseAuth.instance.currentUser?.email}!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      userData=await getUserData()??{};

      // Navigate to Home screen
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
  static Future<void> loginWithEmailAndPassword(String email, String password, BuildContext context,) async {
    if (email == "" || password == "") {
      Fluttertoast.showToast(
        msg: "Please complete your credentials! Dumbass",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);


      Fluttertoast.showToast(
        msg: "Login success as ${FirebaseAuth.instance.currentUser?.email}!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );

      userData=await getUserData()??{};
      Navigator.pushReplacementNamed(context, '/Home');
    } on FirebaseAuthException catch (e) {
      if (e.code=="invalid-credential"){
        Fluttertoast.showToast(
          msg: "Wrong email or password!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      }
      else{
        Fluttertoast.showToast(
          msg: "$e",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  // sign up methods
  static Future<void> createAccountWithEmailAndPassword(String email, String password, String confirmPassword, BuildContext context,) async {
    if (password != confirmPassword) {
      Fluttertoast.showToast(
        msg: "Passwords do not match!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    try {
      UserCredential credential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );



      await createUserData(credential,context);
      // create success
      Fluttertoast.showToast(
        msg: "Account created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(email: email),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "Passwords too easy!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "The account already exists for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: "Invalid email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // user
  static Future<void> createUserData(UserCredential userCredential,BuildContext context) async {
    User? user = userCredential.user;

    if (user != null) {
      String? username = await promptForUsername(context);
      if (username == null || username.trim().isEmpty) {
        print("Username was not provided.");
        return; // User cancelled or didn't enter a valid name
      }

      print("creating user data for email: ${user.email}");
      Map<String, dynamic> userData = {
        "username":username,
        "email": user.email,
        "createdAt": DateTime.now().toIso8601String(),
        "phoneNumber": user.phoneNumber ?? "",
      };
      try {
        print("Saving data to: users/${user.uid}");
        await dbRef.child("users").child(user.uid).set(userData);
        print("User data written successfully!");
      } catch (e) {
        print('Failed to create user data: $e');
        // You might want to notify the user or retry
      }
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
              onPressed: () => Navigator.of(context).pop(null), // Cancel
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

  static Future<Map<String, dynamic>?> getUserData() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    DataSnapshot snapshot = await dbRef.child("users").child(user.uid).get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      return null;
    }
  }


}
