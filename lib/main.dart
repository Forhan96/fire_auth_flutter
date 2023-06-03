import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fire_auth/fire_auth_app.dart';
import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/providers/checout_provider.dart';
import 'package:fire_auth/providers/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_test_51NEeE2FccomtwmmA3CuoWHIQVUC20duCDLfhz7Zq9bYxnux8o2XxuFNdO1RL9SznIaiKsjf2HlxT8o6boHEp0VR300sMQi3Sr1";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  requestPermission();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: Platform.isAndroid,
    badge: true,
    sound: true,
  );
  AwesomeNotifications().initialize(null, [
    // notification icon
    NotificationChannel(
      channelGroupKey: 'basic_test',
      channelKey: 'basic',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      channelShowBadge: true,
      importance: NotificationImportance.High,
      enableVibration: true,
    ),

    NotificationChannel(
        channelGroupKey: 'image_test',
        channelKey: 'image',
        channelName: 'image notifications',
        channelDescription: 'Notification channel for image tests',
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        channelShowBadge: true,
        importance: NotificationImportance.High)

    //add more notification type with different configuration
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
        ChangeNotifierProvider<HomeProvider>.value(value: HomeProvider()),
        ChangeNotifierProvider<CheckoutProvider>.value(value: CheckoutProvider()),
      ],
      child: const FireAuthApp(),
    ),
  );
}
