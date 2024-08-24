import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);


    Future<String?> getToken() async {       //  Get the token
      String? token = await _fcm.getToken();
      print('Token: $token');
      return token;
    }
  }

  Future<void> backgroundHandler(RemoteMessage message) async {    //  listen to backgroundHandler
    print('Handling a background message ${message.messageId}');
  }
}