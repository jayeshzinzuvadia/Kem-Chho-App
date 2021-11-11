import 'package:kem_chho_app/services/databaseService.dart';

class SearchController {
  DatabaseService _databaseService = DatabaseService();

  Future handleSearchAppUsers(String userName) async {
    return await _databaseService.getUserByUsername(userName);
  }

  Future handleConversation(String chatRoomId, chatRoomMap) async {
    return await _databaseService.createChatRoom(chatRoomId, chatRoomMap);
  }
}
