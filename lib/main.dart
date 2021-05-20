import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/app.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';
import 'initial_register.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(
    Provider(
        create: (_) => di.sl<AuthBase>(), builder: (context, _) => MyApp()),
  );
}
