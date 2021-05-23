import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/pages/activity_timer_builder.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/pages/dashboard.dart';
import 'package:time_tracker_app/app/signIn/auth_builder.dart';
import 'package:time_tracker_app/app/signIn/signin.dart';

class SlideTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  SlideTransitionRoute(this.widget)
      : super(
          pageBuilder: (_, animation, __) => widget,
          transitionsBuilder: (_, animation, __, widget) => SlideTransition(
            position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: widget,
          ),
        );
}

class Routes {
  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return SlideTransitionRoute(AuthBuilder());
      case '/signin':
        return SlideTransitionRoute(SignIn());
      case '/dashboard':
        return SlideTransitionRoute(Dashboard());
      case '/activity':
        return SlideTransitionRoute(ActivityTimerBuilder(
          activity: settings.arguments as Activity,
        ));
      default:
        throw Exception('No matched route found.');
    }
  }
}
