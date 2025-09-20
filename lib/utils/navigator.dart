import 'package:flutter/material.dart';
import 'package:sotaynamduoc/gen/i18n/locales/app_localizations.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/ui/widget/custom_dialog.dart';

class NavigationService {
  NavigationService._internal();

  static final NavigationService instance = NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pushReplacement(String routeName) {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  popToRootView() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  pop() {
    navigatorKey.currentState?.pop();
  }

  popWithParam(param) {
    navigatorKey.currentState?.pop(param);
  }

  showDialogTokenExpired() {
    BuildContext? context = navigatorKey.currentState?.overlay?.context;
    if (context == null) {
      return;
    }
    final localizations = AppLocalizations.of(context);
    String? message = localizations?.tokenExpiredMessage;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CustomDialog(
        content: message,
        titleSubmit: 'OK',
        onSubmit: () {
          pushReplacement(Routes.loginScreen);
        },
      ),
    );
  }
}
