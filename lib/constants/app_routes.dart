import 'package:get/get.dart';
import 'package:sotaynamduoc/screen/splash_screen.dart';
import 'package:sotaynamduoc/screen/home_screen.dart';
import 'package:sotaynamduoc/ui/screen/setting/settings_screen.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/settings', page: () => SettingsScreen()),
  ];
}
