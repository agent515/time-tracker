import 'package:flutter/material.dart';
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
        return SlideTransitionRoute(SignIn());
      case '/signin':
        return SlideTransitionRoute(SignIn());
      default:
        throw Exception('No matched route found.');
    }
  }
}
