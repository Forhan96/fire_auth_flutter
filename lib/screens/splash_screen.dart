import 'package:fire_auth/components/loading_animation.dart';
import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkState() async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    // bool isLoggedIn = await authProvider.isUserSignedIn();
    bool isLoggedIn = false;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.HOME_SCREEN);
    } else {
      Navigator.pushReplacementNamed(context, Routes.SIGN_IN_SCREEN);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      checkState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Loader(),
      ),
    );
  }
}
