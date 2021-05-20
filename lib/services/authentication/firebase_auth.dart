import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_app/services/authentication/app_user.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';

class FirebaseAuthImpl extends AuthBase {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // * FirebaseAuth.instance can be injected here
  // * FirebaseAuthImpl(this._auth)

  AppUser _firebaseUsertoAppUser(User user) => AppUser(userId: user.uid);

  @override
  AppUser get currentUser => _firebaseUsertoAppUser(_auth.currentUser!);

  @override
  Stream<AppUser> onAuthStateChanged() {
    return _auth
        .authStateChanges()
        .map((User? user) => AppUser(userId: user?.uid));
  }

  @override
  Future<AppUser> signInAnonymously() async {
    await _auth.signInAnonymously();
    return currentUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
