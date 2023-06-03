import 'package:fire_auth/components/default_button.dart';
import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Signed In",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              DefaultButton(
                text: "Try Notification",
                onPressed: () {
                  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                  authProvider.sendNotification(authProvider.token ?? "", "Logged in successfully", 'Login Notification');
                },
              ),
              SizedBox(
                height: 50.h,
              ),
              DefaultButton(
                text: "Sign Out",
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).signOut();
                  Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (_) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
