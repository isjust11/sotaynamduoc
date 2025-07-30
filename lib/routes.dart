import 'package:flutter/material.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/ui/screen/setting/settings_screen.dart';
import 'package:sotaynamduoc/ui/screen/news/news_detail_screen.dart';
import 'package:sotaynamduoc/ui/screen/news/news_list_screen.dart';
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
  static const String newsListScreen = "/newsListScreen";
  static const String newsDetailScreen = "/newsDetailScreen";

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
          child: NewsDetailScreen(
            news: args,
          ),
          type: PageTransitionType.fade,
        );
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
