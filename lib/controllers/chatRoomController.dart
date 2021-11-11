import 'package:kem_chho_app/services/databaseService.dart';

import '../services/authService.dart';

class ChatRoomController {
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

  Future getChatRooms(String userName) {
    return _databaseService.getChatRooms(userName);
  }

  Future handleUserSignOut() {
    return _authService.signOut();
  }
}
