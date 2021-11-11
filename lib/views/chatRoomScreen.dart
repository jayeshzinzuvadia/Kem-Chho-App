import 'package:flutter/material.dart';
import 'package:kem_chho_app/controllers/chatRoomController.dart';
import 'package:kem_chho_app/services/helperService.dart';
import 'package:kem_chho_app/views/authenticate.dart';
import 'package:kem_chho_app/views/conversationScreen.dart';
import 'package:kem_chho_app/views/search.dart';
import 'package:kem_chho_app/widgets/constants.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  ChatRoomController _controller = ChatRoomController();
  Stream chatRoomsStream;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    HelperConstants.myName =
        await HelperFunctions.getAppUserNameSharedPreference();
    _controller.getChatRooms(HelperConstants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UniversalConstant.APP_NAME),
        backgroundColor: Colors.grey[800],
        actions: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.logout),
            ),
            onTap: () {
              _controller.handleUserSignOut();
              setState(() {
                HelperFunctions.saveAppUserLoggedInSharedPreference(false);
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Authenticate(),
                ),
              );
            },
          ),
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        },
        backgroundColor: Colors.grey[800],
      ),
    );
  }

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.docs[index]
                        .data()["chatRoomId"]
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(HelperConstants.myName, ""),
                    chatRoomId: snapshot.data.docs[index].data()["chatRoomId"],
                  );
                },
              )
            : Container();
      },
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile({this.userName, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(width: 10),
            Text(
              userName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(
              chatRoomId: chatRoomId,
            ),
          ),
        );
      },
    );
  }
}
