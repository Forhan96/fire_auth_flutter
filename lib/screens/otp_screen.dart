import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtpFieldController _otpController = OtpFieldController();
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
                "OTP"
                "",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 50.h,
              ),
              OTPTextField(
                controller: _otpController,
                length: 6,
                fieldWidth: 30,
                width: MediaQuery.of(context).size.width,
                onCompleted: (otp) {
                  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                  authProvider.verifyOTP(otp).then((value) {
                    Navigator.pushNamedAndRemoveUntil(context, Routes.HOME_SCREEN, (route) => false);
                    authProvider.sendNotification(authProvider.token ?? "", "Logged in successfully", 'Login Notification');
                  });
                },
              ),
              // SizedBox(
              //   height: 50.h,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
