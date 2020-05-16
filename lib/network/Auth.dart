import 'package:firebase_auth/firebase_auth.dart';

abstract class BasicAuth {
  Future<String> signIn(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> signOut();
}

class Auth implements BasicAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
