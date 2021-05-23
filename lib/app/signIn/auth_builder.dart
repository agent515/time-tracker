import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/features/time-tracker/presentation/pages/dashboard.dart';
import 'package:time_tracker_app/app/signIn/signin.dart';
import 'package:time_tracker_app/services/authentication/app_user.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';
import 'package:provider/provider.dart';

class AuthBuilder extends StatefulWidget {
  AuthBuilder({Key? key}) : super(key: key);

  @override
  _AuthBuilderState createState() => _AuthBuilderState();
}

class _AuthBuilderState extends State<AuthBuilder> {
  @override
  Widget build(BuildContext context) {
    final _stream = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
      stream: _stream.onAuthStateChanges,
      builder: (BuildContext context, AsyncSnapshot<AppUser?> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.active) {
          AppUser? user = userSnapshot.data;
          if (user == null) {
            return SignIn();
          }
          return Dashboard();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
