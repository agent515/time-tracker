import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_app/services/authentication/app_user.dart';
import 'package:time_tracker_app/services/authentication/auth_base.dart';

class FirebaseAuthImpl implements AuthBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * FirebaseAuth.instance can be injected here
  // * FirebaseAuthImpl(this._auth)

  AppUser _firebaseUsertoAppUser(User user) => AppUser(userId: user.uid);

  @override
  AppUser get currentUser => _firebaseUsertoAppUser(_auth.currentUser!);

  @override
  Stream<AppUser> get onAuthStateChanges =>
      _auth.authStateChanges().map((User? user) => AppUser(userId: user!.uid));

  @override
  Future<AppUser> signInAnonymously() async {
    final credential = await _auth.signInAnonymously();
    if (credential.user != null) {
      return _firebaseUsertoAppUser(credential.user!);
    }
    return AppUser(userId: '1234');
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
