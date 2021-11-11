import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kem_chho_app/widgets/constants.dart';

class DatabaseService {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection(DatabaseConstants.APPUSERS_COLLECTION)
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection(DatabaseConstants.APPUSERS_COLLECTION)
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance
        .collection(DatabaseConstants.APPUSERS_COLLECTION)
        .add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection(DatabaseConstants.CHATROOM_COLLECTION)
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) => print(e.toString()));
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection(DatabaseConstants.CHATROOM_COLLECTION)
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) => print(e.toString()));
  }

  Future getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection(DatabaseConstants.CHATROOM_COLLECTION)
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: false)
        .snapshots();
  }

  Future getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection(DatabaseConstants.CHATROOM_COLLECTION)
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
