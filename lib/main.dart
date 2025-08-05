import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gan/pages/CreatePost.dart';
import 'package:gan/pages/ExchangeVoucher.dart';
import 'package:gan/pages/FavoritePost.dart';
import 'package:gan/pages/GroupChat.dart';
import 'package:gan/pages/GroupChatDetail.dart';
import 'package:gan/pages/GroupChatRoom.dart';
import 'package:gan/pages/Home.dart';
import 'package:gan/pages/Login.dart';
import 'package:gan/pages/PetImageAnalysis.dart';
import 'package:gan/pages/TakePicture.dart';
import 'package:gan/pages/Setting.dart';
import 'package:gan/pages/SignUp.dart';
import 'package:gan/pages/UserProfile.dart';
import 'package:gan/pages/Voucher.dart';
import 'package:gan/services/AuthService.dart';
import 'package:gan/services/MapService.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:gan/services/RecognitionService.dart';
import 'package:gan/services/NotificationService.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tflite_v2/tflite_v2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await MapService.getPermission();
  await RecognitionService.loadModel();
  await NotificationService.setupNotification();
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorService.navigatorKey,
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
        '/GroupChat': (context) => const GroupChat(),
        '/UserProfile': (context) => UserProfile(viewingUID: AuthService.uid),
        '/Setting': (context) => const Setting(),
        '/CreatePost': (context) => const CreatePost(),
        '/Voucher': (context) => const Voucher(),
        '/ExchangeVoucher': (context) => const ExchangeVoucher(),
      },
    );
  }
}
