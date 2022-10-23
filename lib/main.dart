import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fire_auth/fire_auth_app.dart';
import 'package:fire_auth/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ],
      child: const FireAuthApp(),
    ),
  );
}
