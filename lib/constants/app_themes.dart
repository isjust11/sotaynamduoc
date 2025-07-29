import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static const Color dodgerBlue = Color.fromRGBO(29, 161, 242, 1);
  static const Color whiteLilac = Color.fromRGBO(248, 250, 252, 1);
  static const Color blackPearl = Color.fromRGBO(30, 31, 43, 1);
  static const Color brinkPink = Color.fromRGBO(255, 97, 136, 1);
  static const Color juneBud = Color.fromRGBO(186, 215, 97, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color nevada = Color.fromRGBO(105, 109, 119, 1);
  static const Color ebonyClay = Color.fromRGBO(40, 42, 58, 1);

  static String font1 = "ProductSans";
  static String font2 = "Roboto";
  //constants color range for light theme
  //main color
  static const Color _lightPrimaryColor = dodgerBlue;

  //Background Colors
  static const Color _lightBackgroundColor = whiteLilac;
  static const Color _lightBackgroundAppBarColor = _lightPrimaryColor;
  static const Color _lightBackgroundSecondaryColor = white;
  static const Color _lightBackgroundAlertColor = blackPearl;
  static const Color _lightBackgroundActionTextColor = white;
  static const Color _lightBackgroundErrorColor = brinkPink;
  static const Color _lightBackgroundSuccessColor = juneBud;

  //Text Colors
  static const Color _lightTextColor = Colors.black;
  static const Color _lightAlertTextColor = Colors.black;
  static const Color _lightTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _lightBorderColor = nevada;

  //Icon Color
  static const Color _lightIconColor = nevada;

  //form input colors
  static const Color _lightInputFillColor = _lightBackgroundSecondaryColor;
  static const Color _lightBorderActiveColor = _lightPrimaryColor;
  static const Color _lightBorderErrorColor = brinkPink;

  //constants color range for dark theme
  static const Color _darkPrimaryColor = dodgerBlue;

  //Background Colors
  static const Color _darkBackgroundColor = ebonyClay;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  static const Color _darkBackgroundSecondaryColor =
      Color.fromRGBO(0, 0, 0, .6);
  static const Color _darkBackgroundAlertColor = blackPearl;
  static const Color _darkBackgroundActionTextColor = white;

  static const Color _darkBackgroundErrorColor =
      Color.fromRGBO(255, 97, 136, 1);
  static const Color _darkBackgroundSuccessColor =
      Color.fromRGBO(186, 215, 97, 1);

  //Text Colors
  static const Color _darkTextColor = Colors.white;
  static const Color _darkAlertTextColor = Colors.black;
  static const Color _darkTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _darkBorderColor = nevada;

  //Icon Color
  static const Color _darkIconColor = nevada;

  static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  static const Color _darkBorderActiveColor = _darkPrimaryColor;
  static const Color _darkBorderErrorColor = brinkPink;

  //text theme for light theme
  static final TextTheme _lightTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 20.0, color: _lightTextColor),
    bodyLarge: TextStyle(fontSize: 16.0, color: _lightTextColor),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey),
    bodySmall: TextStyle(fontSize: 12.0, color: _lightBackgroundAppBarColor),
    titleLarge: TextStyle(fontSize: 16.0, color: _lightTextColor),
    titleMedium: TextStyle(fontSize: 16.0, color: _lightTextColor),
    titleSmall: TextStyle(fontSize: 12.0, color: _lightBackgroundAppBarColor),
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: font1,
    scaffoldBackgroundColor: _lightBackgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
    ),
    appBarTheme: const AppBarTheme(
      color: _lightBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _lightTextColor),
      elevation: 0,
      titleTextStyle: TextStyle(color: _lightTextColor, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightBackgroundSecondaryColor,
      background: _lightBackgroundColor,
      surface: _lightBackgroundSecondaryColor,
      onPrimary: _lightTextColor,
      onSecondary: _lightTextColor,
      onBackground: _lightTextColor,
      onSurface: _lightTextColor,
    ),
    textTheme: _lightTextTheme,
    cardColor: _lightBackgroundSecondaryColor,
    dividerColor: _lightBorderColor,
    iconTheme: const IconThemeData(color: _lightIconColor),
    buttonTheme: const ButtonThemeData(buttonColor: _lightPrimaryColor),
  );

//text theme for dark theme
  /*static final TextStyle _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle;
  static final TextStyle _darkScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _darkTextColor, fontWeight: FontWeight.w500);
  static final TextStyle _darkScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0,
      color: _darkBackgroundAppBarColor,
      fontWeight: FontWeight.w100);*/

  static final TextTheme _darkTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 20.0, color: _darkTextColor),
    bodyLarge: TextStyle(fontSize: 16.0, color: _darkTextColor),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey),
    bodySmall: TextStyle(fontSize: 12.0, color: _darkBackgroundAppBarColor),
    titleLarge: TextStyle(fontSize: 16.0, color: _darkTextColor),
    titleMedium: TextStyle(fontSize: 16.0, color: _darkTextColor),
    titleSmall: TextStyle(fontSize: 12.0, color: _darkBackgroundAppBarColor),
  );

  //the dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: font1,
    scaffoldBackgroundColor: _darkBackgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
    ),
    appBarTheme: const AppBarTheme(
      color: _darkBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _darkTextColor),
      elevation: 0,
      titleTextStyle: TextStyle(color: _darkTextColor, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkBackgroundSecondaryColor,
      background: _darkBackgroundColor,
      surface: _darkBackgroundSecondaryColor,
      onPrimary: _darkTextColor,
      onSecondary: _darkTextColor,
      onBackground: _darkTextColor,
      onSurface: _darkTextColor,
    ),
    textTheme: _darkTextTheme,
    cardColor: _darkBackgroundSecondaryColor,
    dividerColor: _darkBorderColor,
    iconTheme: const IconThemeData(color: _darkIconColor),
    buttonTheme: const ButtonThemeData(buttonColor: _darkPrimaryColor),
  );
}
