import 'package:get/get.dart';
import 'package:sotaynamduoc/screen/account_screen.dart';
import 'package:sotaynamduoc/screen/auth/update_profile_screen.dart';
import 'package:sotaynamduoc/screen/splash_screen.dart';
import 'package:sotaynamduoc/screen/auth/signin_screen.dart';
import 'package:sotaynamduoc/screen/auth/signup_screen.dart';
import 'package:sotaynamduoc/screen/home_screen.dart';
import 'package:sotaynamduoc/screen/settings_screen.dart';
import 'package:sotaynamduoc/screen/auth/reset_password_screen.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/signin', page: () => SignInScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/account', page: () => AccountScreen()),
    GetPage(name: '/settings', page: () => SettingsScreen()),
    GetPage(name: '/reset-password', page: () => ResetPasswordScreen()),
    GetPage(name: '/update-profile', page: () => UpdateProfileScreen()),
  ];
}
