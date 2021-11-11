import 'package:kem_chho_app/services/databaseService.dart';

import '../services/authService.dart';

class SignUpController {
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

  handleUserSignUp(String email, String password) {
    return _authService.signUpWithEmailAndPassword(email, password);
  }

  uploadUserData(userMap) {
    return _databaseService.uploadUserInfo(userMap);
  }
}
