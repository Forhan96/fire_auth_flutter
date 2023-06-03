import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  String VERIFICATION_ID = "";
  int? RESEND_TOKEN;

  String _token = "";
  String get token => _token;

  set token(String token) {
    _token = token;
    notifyListeners();
  }

  Future<void> verifyPhone(String mobile) async {
    var mobileToSend = mobile;

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            VERIFICATION_ID = verId;
          },
          codeSent: (String verificationId, int? resendToken) async {
            VERIFICATION_ID = verificationId;
            RESEND_TOKEN = resendToken;
            Fluttertoast.showToast(
              msg: "Verification code is sent.",
            );
          },
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            throw exceptio;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VERIFICATION_ID,
        smsCode: otp,
      );
      final UserCredential user = await _firebaseAuth.signInWithCredential(credential);
      final User currentUser = _firebaseAuth.currentUser!;
      print(user);

      if (currentUser.uid != "") {
        print(currentUser.uid);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> isUserLoggedIn() async {
    if (_firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<void> sendNotification(String token, String body, String title) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      //no permission of local notification
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      //show notification
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        //simgple notification
        id: 123,
        channelKey: 'basic', //set configuration with key "basic"
        title: 'Welcome to the App',
        body: 'You signed in successfully',
      ));
    }
  }

  showError(error) {
    throw error.toString();
  }
}
