import 'package:fire_auth/router/routes.dart';
import 'package:fire_auth/screens/home_screen.dart';
import 'package:fire_auth/screens/otp_screen.dart';
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

  static final Handler _notFoundHandler = Handler(handlerFunc: (context, parameters) {
    print("No Router Found!");
    return null;
  });
  void setupRouter() {
    //account
    // router.define(
    //   Routes.AUTH_WRAPPER,
    //   handler: _authWrapperHandler,
    //   transitionType: TransitionType.fadeIn,
    // );
    router.define(
      Routes.SPLASH_SCREEN,
      handler: _splashScreenHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      Routes.SIGN_IN_SCREEN,
      handler: _signInScreenHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.OTP_SCREEN,
      handler: _otpScreenHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      Routes.HOME_SCREEN,
      handler: _homeScreenHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.notFoundHandler = _notFoundHandler;
  }
}
