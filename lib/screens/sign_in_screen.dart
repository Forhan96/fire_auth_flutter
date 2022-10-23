import 'package:fire_auth/components/default_button.dart';
import 'package:fire_auth/components/default_text_field.dart';
import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(
                "Phone Sign-in",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 50.h,
              ),
              DefaultTextField(
                controller: _phoneController,
                hintText: "Phone number",
              ),
              SizedBox(
                height: 50.h,
              ),
              DefaultButton(
                text: "Continue",
                onPressed: () {
                  String phoneNumber = _phoneController.text.trim();
                  if (phoneNumber.isEmpty) {
                    Fluttertoast.showToast(msg: "Invalid Phone Number");
                    return;
                  }
                  Provider.of<AuthProvider>(context, listen: false).verifyPhone(_phoneController.text).then((value) {
                    // Fluttertoast.showToast(
                    //   msg: "Verification code is sent.",
                    // );
                    Navigator.pushNamed(context, Routes.OTP_SCREEN);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
