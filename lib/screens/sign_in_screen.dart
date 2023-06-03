import 'package:fire_auth/components/default_button.dart';
import 'package:fire_auth/components/default_text_field.dart';
import 'package:fire_auth/providers/auth_provider.dart';
import 'package:fire_auth/router/routes.dart';
import 'package:fire_auth/utils/color_const.dart';
import 'package:fire_auth/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget with InputValidationMixin {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController _phoneController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Text(
                  "Phone Sign-in",
                  style: TextStyle(fontSize: 24),
                ),
                Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_7ciiygtc.json',
                  height: 200.h,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Form(
                  key: formKey,
                  child: DefaultTextField(
                    controller: _phoneController,
                    hintText: "Phone number",
                    borderColor: AppColors.primaryColor,
                    validator: (phone) {
                      if (isValidPhone(phone ?? "")) {
                        return null;
                      } else {
                        return 'Enter a valid phone number with country code';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                DefaultButton(
                  text: "Continue",
                  onPressed: () {
                    // String phoneNumber = _phoneController.text.trim();
                    // if (phoneNumber.isEmpty) {
                    //   Fluttertoast.showToast(msg: "Invalid Phone Number");
                    //   return;
                    // }
                    if (!formKey.currentState!.validate()) {
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
      ),
    );
  }
}
