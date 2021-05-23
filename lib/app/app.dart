import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/models/activity_list_provider.dart';
import 'package:time_tracker_app/core/app_theme.dart';
import 'package:time_tracker_app/core/routes/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivityListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time Tracker',
        onGenerateRoute: Routes.routes,
        initialRoute: '/',
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
