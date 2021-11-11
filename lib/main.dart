import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kem_chho_app/services/helperService.dart';
import 'package:kem_chho_app/views/authenticate.dart';
import 'package:kem_chho_app/widgets/constants.dart';

import 'views/chatRoomScreen.dart';

void main() async {
  // Below steps are required for firebase apps
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getAppUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UniversalConstant.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Capriola",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (userIsLoggedIn != null)
          ? (userIsLoggedIn ? ChatRoom() : Authenticate())
          : Authenticate(),
      //Authenticate(),
    );
  }
}
