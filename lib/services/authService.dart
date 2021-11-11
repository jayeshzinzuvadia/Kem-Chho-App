import 'package:firebase_auth/firebase_auth.dart';
import 'package:kem_chho_app/models/appUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Use AppUser object from the User class
  AppUser _appUserFromUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;
      return _appUserFromUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;
      return _appUserFromUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  // AppUser will provide the email to change the password
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
