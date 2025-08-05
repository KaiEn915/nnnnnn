import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationService {
  static String serverAccessToken = "";
  static String endPoint =
      "https://fcm.googleapis.com/v1/projects/petfinder-ba6f8/messages:send";


  static Future<String> getAccessToken() async {
    final serviceAccountJson = await loadServiceAccountJsonFile();

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    ServiceAccountCredentials serviceAccountCredentials =
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson);

    http.Client client = await auth.clientViaServiceAccount(
      serviceAccountCredentials,
      scopes,
    );

    // get the access key
    auth.AccessCredentials credentials = await auth
        .obtainAccessCredentialsViaServiceAccount(
          serviceAccountCredentials,
          scopes,
          client,
        );

    client.close();
    return credentials.accessToken.data;
  }

  static Future<Map<String, dynamic>> loadServiceAccountJsonFile() async {
    String data = await DefaultAssetBundle.of(NavigatorService.navigatorKey.currentContext!).loadString("assets/serviceAccount.json");
    final jsonResult = jsonDecode(data);
    return jsonResult;
  }

  // topic for group notification, one message for all members, topicId typically is groupChatId
  static void updateTopicSubscription(
    String topicId,
    bool notificationsEnabled,
  ) async {
    if (notificationsEnabled) {
      await FirebaseMessaging.instance.subscribeToTopic(topicId);
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicId);
    }
  }

  static void sendTopicNotification(
    String topic,
    String title,
    String message,
  ) async {
    ;
    if (serverAccessToken == "") serverAccessToken = await getAccessToken();

    final Map<String, dynamic> body = {
      'message': {
        'topic': topic,
        "notification": {"title": title, "body": message},
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "groupChat_id": topic,
        },
      },
    };

    final response = await http.post(
      Uri.parse(endPoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
      body: jsonEncode(body),
    );

    print(response.body);
    if (response.statusCode == 200) {
      print('OK!');
    } else {
      print("NOT OK! ${response.statusCode}");
    }
  }

  static Future<void> sendPushNotification(
    String token,
    String title,
    String message,
  ) async {
    if (serverAccessToken == "") serverAccessToken = await getAccessToken();

    final Map<String, dynamic> body = {
      'message': {
        'token': token,
        "notification": {"title": title, "body": message},
      },
    };

    final response = await http.post(
      Uri.parse(endPoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('OK!');
    } else {
      print("NOT OK! ${response.statusCode}");
    }
  }

  static Future setupNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔔 Foreground message: ${message.notification?.title}");
    });
    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _firebaseMessagingBackgroundHandler(RemoteMessage());
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageNavigation(message);
    });
  }

  static void _handleMessageNavigation(RemoteMessage message) {
    if (message.data.containsKey('groupChat_id')) {
      final groupChatId = message.data['groupChat_id'];

      // Use your preferred navigation method
      NavigatorService.openPage(groupChatId, true);
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print("Handling a background message: ${message.messageId}");
  }
}
