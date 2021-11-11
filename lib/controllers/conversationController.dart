import 'package:kem_chho_app/services/databaseService.dart';

class ConversationController {
  DatabaseService _databaseService = DatabaseService();

  Future addConversationMessages(String chatRoomId, messageMap) async {
    return await _databaseService.addConversationMessages(
        chatRoomId, messageMap);
  }

  Future getConversationMessages(String chatRoomId) async {
    return await _databaseService.getConversationMessages(chatRoomId);
  }
}
