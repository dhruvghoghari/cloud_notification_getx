import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.getToken().then((token) async{   // Token Generate
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("token", token.toString());
  });

   FirebaseMessaging.onMessage.listen(showFlutterNotification);
  runApp(const MyApp());
}
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {

    var firebaseTitle  = notification.title.toString();
    var firebaseBody = notification.body.toString();

    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 10,
    //       channelKey: 'alerts',
    //       title: firebaseTitle,
    //       body: firebaseBody,
    //     )
    // );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
