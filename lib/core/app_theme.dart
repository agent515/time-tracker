import 'package:time_tracker_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: kBlackDark,
    accentColor: kPurpleColor,
    brightness: Brightness.light,
    fontFamily: 'Open Sans',
    iconTheme: IconThemeData(color: kBlackDark),
    textTheme: TextTheme(
      headline3: TextStyle(
          fontSize: 32, fontWeight: FontWeight.w600, color: Colors.black),
      headline4: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
      headline5: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
      headline6: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
      bodyText1: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
      bodyText2: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  );
}
