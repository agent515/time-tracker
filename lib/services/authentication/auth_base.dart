import 'package:time_tracker_app/services/authentication/app_user.dart';

abstract class AuthBase {
  AppUser get currentUser;
  Stream<AppUser> get onAuthStateChanges;

  Future<AppUser> signInAnonymously();
  Future<void> signOut();
}
