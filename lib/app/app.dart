import 'package:flutter/material.dart';
import 'package:time_tracker_app/core/constants/constants.dart';
import 'package:time_tracker_app/core/routes/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker',
      onGenerateRoute: Routes.routes,
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: kBlackDark,
        accentColor: kPurpleColor,
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
      ),
    );
  }
}
