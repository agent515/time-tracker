import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.4,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 16, right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Time Tracker',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Expanded(
                          child: SvgPicture.asset(
                              'assets/svg/time_management.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  child: Center(
                    child: CustomRoundButton(
                      child: Center(
                        child: Text('Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white)),
                      ),
                      onpressed: () async {
                        try {
                          auth.signInAnonymously();
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRoundButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onpressed;

  const CustomRoundButton({
    Key? key,
    required this.child,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(5.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).accentColor,
        ),
      ),
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.5,
          child: child),
      onPressed: onpressed,
    );
  }
}
