import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gan/services/NavigatorService.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationService {

  static String serverAccessToken="";
  static String endPoint="https://fcm.googleapis.com/v1/projects/petfinder-ba6f8/messages:send";

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "petfinder-ba6f8",
      "private_key_id": "87292f6cd5f88c0ee8d5e35412917b7ca706b1c3",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC/uRy0366Ogx5X\nFwbXDS7iAnuZoa19BOOROA8wc19jSzAuXVLdx4COCQ+jM444oK84zM6g47Efc9IV\nIlxIrHj1mDGnmw+eZGbdtVRnTe2C8BK+Od4HQtiPmPtSK8vdE8moFNlZVudx4DRj\n+WGYCmiXELDy9xcFxMpwTua3oYbgSyjnLzV6bsaplR8jWAyJYyc5b7uOB7+H1VR1\neMM20R0/XMszbgoSErbdwU+SFpvz3J2w33taKIL2Psq058oG8k8RaTu5Tc0d+Bx7\nO04nHs82enYiAzXNEN0GvdtzMXA8ktDOYDxTXuwE8Z8kZqE3vz/hP25Rr2P8GrvI\npoavWglRAgMBAAECggEACRT7Q6Qu8ChM6SI5nDlPJbypXzs17SysnQXzTj/A3oLC\nywd3s/LN56yNNZVtIMiX1FB7X0q56rwBUSf6CCVHa5bkj0R8pmuqJcl/sI8T97Zo\npOM33c8wVAkSqq9Rbm0QCerG6wD/YLkWsj+vfFTN5I4RW8kRqZ/LWSubqUo5Ceng\niZQ7CJZlaGUOCKfbX+g86LFbp1G7wSfhPe028p7isljxGfXBVceUHC9tkiRxc2mt\n4tO84/6noPCfFwEXFftLvGdwKecoeaMUwRDRZ86unrehp8alFSlj4aHc2uaiq6dL\nhcx4DueDdmevOPRKPtt8XMLbW+AbP1e2mnzqAK0S0wKBgQDnG4C9xnteyEoKluMC\nYGw79KEeAO5XBhUSzPl9meseD5RiEkoNnd8yoHUPnLFo36Q42jFMeSUN/aFUrStA\nUq6EEMdjeAzUiSHVGuh240bUF+LAFGIFJV+8YSlI64N2pMF+e8nhxeqicFjJqvww\n5bNxfVrE3y8KHwyb9kq1lN7NzwKBgQDUX6K1Jr4DQPN4rhw6DEzRN4JE7qjs6DKY\n1dqws7Zuknoo0WmkLTWg33RDdRW9oBA19YK1T/YBb4DNrQO8SbwrAwJcFPIbcCMk\nMc9G3ZW6xFwPp5nHvUyFiTGUPWyeaJySwhNAq5Z6fIwqZcn+mD4W2l8bQ/R8tRso\nVv7iVJGe3wKBgBx1MIct16c2NpfTOKTkRq+jUeul5bNllla4Ush6mY8cEAN7iQ7g\nL8nGJGQFwXrOfyRZCdUG3d85KhKJOFg1VjQA9Ox0re/F6xqYs6NgHSqkvlE0sVU8\n4usJc9H83jVP2FvA1n0sp9XUy7oZifBjeJMzAmhXqy0t4Zma3Fw7tqvVAoGBALrO\nUMHFjVgxVrhtdli9HwjdKdJWl/KjoHX9jnrl6W/Dmn6zDZijR8v1IkCAChqdZAUC\nqvGvnzXODd9c8684sLKo1/eFWR03e0HIKoosORtqw4vloggnA9tmPV0m1pdUb31M\nB0FYbWnaijR1CsPOyLazaPsDwFe9umC2fUc6mkjDAoGAWQ6HDaT4j8FjMAzFk9Ce\n5N5JCXZZwpm0aBNpV8UudTBImn1dHpxs263c398QJjNXQlJHYymNg+ssDtmIk45a\nsAoyZvmHBNUTmiV/i5J6n606wGpid3deWtwsStvWcinfQgj2NMnHthWluSsvRYoL\nszavpKR5X3LKg4Tjyr0cxno=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-fbsvc@petfinder-ba6f8.iam.gserviceaccount.com",
      "client_id": "115861701780266990407",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40petfinder-ba6f8.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };

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
        .obtainAccessCredentialsViaServiceAccount(serviceAccountCredentials, scopes, client);

    client.close();
    return credentials.accessToken.data;
  }

  // topic for group notification, one message for all members, topicId typically is groupChatId
  static void updateTopicSubscription(String topicId, bool notificationsEnabled) async {
    if (notificationsEnabled) {
      await FirebaseMessaging.instance.subscribeToTopic(topicId);
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicId);
    }
  }


  static void sendTopicNotification(String topic,String title, String message)async{;
    if (serverAccessToken=="") serverAccessToken=await getAccessToken();

    final Map<String,dynamic> body={
      'message':
      {
        'topic':topic,
        "notification":
        {
          "title": title,
          "body": message
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "groupChat_id": topic,
        },
      }
    };

    final response = await http.post(
      Uri.parse(endPoint),
      headers:
      {
        'Content-Type': 'application/json',
        'Authorization':'Bearer $serverAccessToken',
      },
      body: jsonEncode(body),
    );

    print(response.body);
    if (response.statusCode==200){
      print('OK!');
    }
    else{
      print("NOT OK! ${response.statusCode}");
    }
  }

  static void sendPushNotification(
    String token,
    String title,
    String message,
  ) async {
    if (serverAccessToken=="") serverAccessToken=await getAccessToken();

    final Map<String,dynamic> body={
       'message':
       {
         'token':token,
         "notification":
         {
           "title": title,
           "body": message
         },
       }
    };

    final response = await http.post(
      Uri.parse(endPoint),
      headers:
      {
        'Content-Type': 'application/json',
        'Authorization':'Bearer $serverAccessToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode==200){
      print('OK!');
    }
    else{
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
      NavigatorService.openPage(groupChatId,true);
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print("Handling a background message: ${message.messageId}");
  }
}
