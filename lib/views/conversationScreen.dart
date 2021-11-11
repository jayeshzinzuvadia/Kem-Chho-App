import 'package:flutter/material.dart';
import 'package:kem_chho_app/controllers/conversationController.dart';
import 'package:kem_chho_app/widgets/constants.dart';
import 'package:kem_chho_app/widgets/styles.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen({this.chatRoomId});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ConversationController _controller = ConversationController();

  TextEditingController messageTextEditingController =
      new TextEditingController();

  Stream chatMessageStream;

  @override
  void initState() {
    _controller.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Chat with user"),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        decoration: InputDecoration(
                          hintText: "Type your message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        child: Icon(
                          Icons.send,
                          color: Colors.grey[850],
                          size: 40.0,
                        ),
                      ),
                      onTap: () {
                        sendMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index].data()["message"],
                    isSendByMe: snapshot.data.docs[index].data()["sendBy"] ==
                        HelperConstants.myName,
                  );
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sendBy": HelperConstants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      _controller.addConversationMessages(widget.chatRoomId, messageMap);
      messageTextEditingController.text = "";
    }
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile({this.message, this.isSendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: isSendByMe ? 0 : 24,
        right: isSendByMe ? 24 : 0,
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: isSendByMe ? Colors.blue[800] : Colors.grey[800],
          borderRadius: isSendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23),
                ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
