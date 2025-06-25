import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/CreatePost.dart';
import 'package:gan/pages/ExchangeVoucher.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/pages/GroupChatDetail.dart';
import 'package:gan/pages/GroupChatRoom.dart';
import 'package:gan/pages/Home.dart';
import 'package:gan/pages/Login.dart';
import 'package:gan/pages/PetImageAnalysis.dart';
import 'package:gan/pages/Scan.dart';
import 'package:gan/pages/Setting.dart';
import 'package:gan/pages/SignUp.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/pages/Voucher.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/MapService.dart';
import 'package:tflite_v2/tflite_v2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();

  await MapService.getPermission();

  await loadModel();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      AuthService.uid=user.uid;
    } else {
      Fluttertoast.showToast(msg: "Signed out successfully");
    }
  });

  runApp(const MyApp());
}

Future<void> loadModel() async{
  String? res = await Tflite.loadModel(
    model: "assets/model.tflite",
    labels: "assets/labels.txt",
  );
  print("Model loaded: $res");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const Login(),
        '/Login': (context) => const Login(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/SignUp': (context) => const SignUp(),
        '/Home': (context) => const Home(),
        '/GroupChat':(context) => const GroupChat(),
        '/UserProfile':(context)=> UserProfile(viewingUID: AuthService.uid),
        '/Scan':(context)=> const Scan(),
        '/Setting':(context)=> const Setting(),
        '/CreatePost':(context)=> const CreatePost(),
        '/Voucher':(context)=> const Voucher(),
        '/ExchangeVoucher':(context)=> const ExchangeVoucher(),
      },
    );
  }
}

