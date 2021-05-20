import 'package:time_tracker_app/services/authentication/app_user.dart';

abstract class AuthBase {
  AppUser get currentUser;

  Future<AppUser> signInAnonymously();
  Future<void> signOut();
  Stream<AppUser> onAuthStateChanged();
}
