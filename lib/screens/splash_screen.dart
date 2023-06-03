import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:fire_auth/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkState() async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isLoggedIn = await authProvider.isUserLoggedIn();

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, Routes.signInScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(
          size: 100,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
