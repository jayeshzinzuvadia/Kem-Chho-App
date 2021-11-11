import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kem_chho_app/controllers/signInController.dart';
import 'package:kem_chho_app/services/helperService.dart';
import 'package:kem_chho_app/widgets/loading_screen.dart';
import '../widgets/styles.dart';
import 'chatRoomScreen.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  SignInController _controller = SignInController();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  QuerySnapshot snapshotUserInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: isLoading
          ? LoadingScreen()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailTextEditingController,
                            decoration: textFieldInputDecoration("Email"),
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Enter valid email address";
                            },
                          ),
                          TextFormField(
                            decoration: textFieldInputDecoration("Password"),
                            controller: passwordTextEditingController,
                            validator: (val) => val.length < 6
                                ? "Enter password of atleast 6 characters"
                                : null,
                            obscureText: true,
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                "Forgot Password?",
                                style: simpleTextStyle(),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                HelperFunctions
                                    .saveAppUserEmailSharedPreference(
                                        emailTextEditingController.text);
                                _controller
                                    .handleUserDetails(
                                        emailTextEditingController.text)
                                    .then((val) {
                                  snapshotUserInfo = val;
                                  print(
                                      "Snapshot length - ${snapshotUserInfo.size}");
                                  HelperFunctions
                                      .saveAppUserNameSharedPreference(
                                          snapshotUserInfo.docs[0]
                                              .data()['name']);
                                });
                                setState(() {
                                  isLoading = true;
                                });
                                _controller
                                    .handleUserSignIn(
                                  emailTextEditingController.text,
                                  passwordTextEditingController.text,
                                )
                                    .then((val) {
                                  if (val != null) {
                                    HelperFunctions
                                        .saveAppUserLoggedInSharedPreference(
                                            true);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatRoom()),
                                    );
                                  }
                                });
                              }
                            },
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "Sign in with Google",
                              style: mediumTextStyle(),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: mediumTextStyle(),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Register now",
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  widget.toggle();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
