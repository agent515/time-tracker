import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/services/authentication/app_user.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
        body: Center(
      child: Container(
        child: OutlinedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
          ),
          child: Text('Sign In'),
          onPressed: () async {
            try {
              AppUser user = await auth.signInAnonymously();
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    ));
  }
}
