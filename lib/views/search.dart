import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kem_chho_app/controllers/searchController.dart';
import 'package:kem_chho_app/views/conversationScreen.dart';
import 'package:kem_chho_app/widgets/constants.dart';
import 'package:kem_chho_app/widgets/styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchController _controller = SearchController();

  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Search User"),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              color: Colors.grey[300],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Search username...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[900],
                        size: 42.0,
                      ),
                    ),
                    onTap: () {
                      initiateSearch();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            searchResultList(),
          ],
        ),
      ),
    );
  }

  initiateSearch() {
    _controller
        .handleSearchAppUsers(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchResultList() {
    return searchSnapshot == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchSnapshot.docs.length,
              itemBuilder: (context, index) {
                return searchResultTile(
                  userName: searchSnapshot.docs[index].data()['name'],
                  userEmail: searchSnapshot.docs[index].data()['email'],
                );
              },
            ),
          );
  }

  Container searchResultTile({String userName, String userEmail}) {
    return Container(
      child: Row(
        children: [
          getProfileImageAsset(),
          Column(
            children: [
              Text(userName, style: mediumTextStyle()),
              SizedBox(height: 5.0),
              Text(userEmail, style: mediumTextStyle())
            ],
          ),
          Spacer(),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                "Message",
                style: mediumTextStyleWhiteColor(),
              ),
            ),
            onTap: () {
              createChatRoomAndStartConversation(userName: userName);
            },
          ),
        ],
      ),
    );
  }

  Widget getProfileImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/default.png');
    Image image = Image(
      image: assetImage,
      width: 50.0,
      height: 50.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(5.0),
    );
  }

  createChatRoomAndStartConversation({String userName}) {
    if (userName != HelperConstants.myName) {
      String chatRoomId = getChatRoomId(userName, HelperConstants.myName);
      List<String> users = [userName, HelperConstants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId,
      };
      _controller.handleConversation(chatRoomId, chatRoomMap);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId: chatRoomId,
          ),
        ),
      );
    } else {
      print("You cannot send message to youself");
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
