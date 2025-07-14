import 'package:flutter/material.dart';
import 'package:sotaynamduoc/controllers/theme_controller.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader();
  final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    String imageLogo = 'assets/images/logo.png';
    // if (themeController.isDarkModeOn == true) {
    //   _imageLogo = 'assets/images/logo.png';
    // }
    return Hero(
      tag: 'logo',
      child: CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              imageLogo,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}
