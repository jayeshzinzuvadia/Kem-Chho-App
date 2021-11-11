import 'package:kem_chho_app/services/databaseService.dart';
import '../services/authService.dart';

class SignInController {
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

  Future handleUserSignIn(String email, String password) async {
    print("email - $email");
    return _authService.signInWithEmailAndPassword(email, password);
  }

  Future handleUserDetails(String email) async {
    return await _databaseService.getUserByUserEmail(email);
  }
}
