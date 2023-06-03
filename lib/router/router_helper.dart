import 'package:fire_auth/router/routes.dart';
import 'package:fire_auth/screens/home_screen.dart';
import 'package:fire_auth/screens/otp_screen.dart';
import 'package:fire_auth/screens/setting_screen.dart';
import 'package:fire_auth/screens/sign_in_screen.dart';
import 'package:fire_auth/screens/splash_screen.dart';
import 'package:fluro/fluro.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  // static final Handler _authWrapperHandler = Handler(handlerFunc: (context, parameters) => const AuthenticationWrapper());

  static final Handler _splashScreenHandler = Handler(handlerFunc: (context, parameters) => SplashScreen());

  //account
  static final Handler _signInScreenHandler = Handler(handlerFunc: (context, parameters) => SignInScreen());
  static final Handler _otpScreenHandler = Handler(handlerFunc: (context, parameters) => OtpScreen());

  static final Handler _homeScreenHandler = Handler(handlerFunc: (context, parameters) => HomeScreen());
  static final Handler _settingsScreenHandler = Handler(handlerFunc: (context, parameters) => SettingScreen());

  static final Handler _notFoundHandler = Handler(handlerFunc: (context, parameters) {
    print("No Router Found!");
    return null;
  });
  void setupRouter() {
    router.define(
      Routes.splashScreen,
      handler: _splashScreenHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      Routes.signInScreen,
      handler: _signInScreenHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.otpScreen,
      handler: _otpScreenHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.homeScreen,
      handler: _homeScreenHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.settingsScreen,
      handler: _settingsScreenHandler,
      transitionType: TransitionType.inFromRight,
    );

    router.notFoundHandler = _notFoundHandler;
  }
}
