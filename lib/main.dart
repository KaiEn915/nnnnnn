import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gan/firebase_options.dart';
import 'package:gan/pages/CreatePost.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/pages/Home.dart';
import 'package:gan/pages/Login.dart';
import 'package:gan/pages/Scan.dart';
import 'package:gan/pages/Setting.dart';
import 'package:gan/pages/SignUp.dart';
import 'package:gan/pages/UserProfile.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();

  runApp(const MyApp());
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
        '/UserProfile':(context)=> UserProfile(),
        '/Scan':(context)=> const Scan(),
        '/Setting':(context)=> const Setting(),
        '/CreatePost':(context)=> const CreatePost(),
      },
    );
  }
}

