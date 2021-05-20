import 'package:get_it/get_it.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';
import 'package:time_tracker_app/services/authentication/firebase_auth_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AuthBase>(() => FirebaseAuthImpl());
}
