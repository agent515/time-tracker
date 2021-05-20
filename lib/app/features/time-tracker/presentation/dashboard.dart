import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
            child: Text('Sign out'),
            onPressed: () async {
              try {
                await auth.signOut();
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ),
    );
  }
}
