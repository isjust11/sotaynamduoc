import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sotaynamduoc/constants/app_routes.dart';
import 'package:sotaynamduoc/constants/app_themes.dart';
import 'package:sotaynamduoc/controllers/auth_controller.dart';
import 'package:sotaynamduoc/controllers/language_controller.dart';
import 'package:sotaynamduoc/controllers/theme_controller.dart';
import 'package:sotaynamduoc/helpers/localization.g.dart';
import 'package:sotaynamduoc/screen/components/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          translations: Localization(),
          locale: languageController.getLocale, // <- Current locale
          navigatorObservers: [
            // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          debugShowCheckedModeBanner: false,
          //defaultTransition: Transition.fade,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: "/",
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }
}
