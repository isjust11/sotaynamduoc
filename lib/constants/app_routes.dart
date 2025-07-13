import 'package:get/get.dart';
import 'package:sotaynamduoc/ui/splash_ui.dart';
import 'package:sotaynamduoc/ui/auth/sign_in_ui.dart';
import 'package:sotaynamduoc/ui/auth/sign_up_ui.dart';
import 'package:sotaynamduoc/ui/home_ui.dart';
import 'package:sotaynamduoc/ui/settings_ui.dart';
import 'package:sotaynamduoc/ui/auth/reset_password_ui.dart';
import 'package:sotaynamduoc/ui/auth/update_profile_ui.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
