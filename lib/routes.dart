import 'package:flutter/material.dart';
import 'package:sotaynamduoc/ui/screen/history/history_screen.dart';
import 'package:sotaynamduoc/ui/screen/qrscanner_screen.dart';
import 'package:sotaynamduoc/ui/screen/screen.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  Routes._();

  //screen name
  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
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

  //init screen name
  static String initScreen() => splashScreen;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return PageTransition(
          child: MainScreen(),
          type: PageTransitionType.fade,
        );
      case splashScreen:
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.fade,
        );
      case loginScreen:
        return PageTransition(
          child: LoginScreen(),
          type: PageTransitionType.fade,
        );
      case historyScreen:
        return PageTransition(
          child: HistoryScreen(),
          type: PageTransitionType.fade,
        );
      case qrScannerScreen:
        return PageTransition(
          child: QRScannerScreen(),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
