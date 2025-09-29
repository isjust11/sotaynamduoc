import 'package:flutter/material.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/ui/screen/setting/settings_screen.dart';
import 'package:sotaynamduoc/ui/screen/news/news_detail_screen.dart';
import 'package:sotaynamduoc/ui/screen/news/news_list_screen.dart';
import 'package:sotaynamduoc/ui/screen/screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sotaynamduoc/ui/screen/test/fcm_test_screen.dart';

class Routes {
  Routes._();

  //screen name
  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
  static const String signupScreen = "/signupScreen";
  static const String mainScreen = "/mainScreen";
  static const String introScreen = "/introScreen";
  static const String settingScreen = "/settingScreen";
  static const String personalScreen = "/personalScreen";
  static const String contactUsScreen = "/contactUsScreen";
  static const String helpGuideScreen = "/helpGuideScreen";
  static const String privacyScreen = "/privacyScreen";
  static const String termOfUseScreen = "/termOfUseScreen";
  static const String productResultScreen = "/productResultScreen";
  static const String qrScannerScreen = "/qrScannerScreen";
  static const String fakeProductScreen = "/fakeProductScreen";
  static const String historyScreen = "/historyScreen";
  static const String newsListScreen = "/newsListScreen";
  static const String newsDetailScreen = "/newsDetailScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String fcmTestScreen = "/fcmTestScreen";
  static const String searchScreen = "/searchScreen";
  //init screen name
  static String initScreen() => splashScreen;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return PageTransition(
          child: MainScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      case splashScreen:
        return PageTransition(
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: SplashScreen(),
          type: PageTransitionType.fade,
        );
      case loginScreen:
        return PageTransition(
          child: SignInScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      case signupScreen:
        return PageTransition(
          child: SignUpScreen(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      case settingScreen:
        return PageTransition(
          child: SettingScreen(),
          type: PageTransitionType.fade,
        );
      case qrScannerScreen:
        return PageTransition(
          child: QRScannerScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case newsListScreen:
        return PageTransition(
          child: NewsListScreen(),
          type: PageTransitionType.fade,
        );
      case newsDetailScreen:
        final args = settings.arguments as NewsModel;
        return PageTransition(
          child: NewsDetailScreen(news: args),
          type: PageTransitionType.fade,
        );
      case forgotPasswordScreen:
        return PageTransition(
          child: ForgotPasswordScreen(),
          type: PageTransitionType.fade,
        );
      case fcmTestScreen:
        return PageTransition(
          child: FCMTestScreen(),
          type: PageTransitionType.fade,
        );
      case searchScreen:
        return PageTransition(
          child: SearchScreen(),
          type: PageTransitionType.fade,
        );
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
