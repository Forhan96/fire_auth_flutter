import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/router/router_helper.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FireAuthApp extends StatefulWidget {
  const FireAuthApp({Key? key}) : super(key: key);

  @override
  State<FireAuthApp> createState() => _FireAuthAppState();
}

class _FireAuthAppState extends State<FireAuthApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RouterHelper().setupRouter();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    getToken(context);

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fire Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const SplashScreen(),
        onGenerateRoute: RouterHelper.router.generator,
        initialRoute: Routes.SPLASH_SCREEN,
      ),
    );
  }
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

void getToken(BuildContext context) async {
  await FirebaseMessaging.instance.getToken().then((token) {
    Provider.of<AuthProvider>(context, listen: false).token = token!;
    print('this is token : ${token}');
  });
}
