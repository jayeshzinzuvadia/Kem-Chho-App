import 'package:flutter/material.dart';
import 'package:kem_chho_app/controllers/signUpController.dart';
import 'package:kem_chho_app/services/helperService.dart';
import 'package:kem_chho_app/views/chatRoomScreen.dart';
import 'package:kem_chho_app/widgets/loading_screen.dart';
import '../widgets/styles.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  SignUpController _controller = SignUpController();

  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

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
                            controller: userNameTextEditingController,
                            decoration: textFieldInputDecoration("User Name"),
                            validator: (val) =>
                                val.isEmpty ? "Enter user name" : null,
                          ),
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
                            controller: passwordTextEditingController,
                            decoration: textFieldInputDecoration("Password"),
                            validator: (val) => val.length < 6
                                ? "Enter password of atleast 6 characters"
                                : null,
                            obscureText: true,
                          ),
                        ],
                      ),
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
                          "Sign up",
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
                          Map<String, String> userInfoMap = {
                            "name": userNameTextEditingController.text,
                            "email": emailTextEditingController.text,
                          };

                          HelperFunctions.saveAppUserNameSharedPreference(
                              userNameTextEditingController.text);
                          HelperFunctions.saveAppUserEmailSharedPreference(
                              emailTextEditingController.text);

                          setState(() {
                            isLoading = true;
                          });
                          _controller
                              .handleUserSignUp(
                            emailTextEditingController.text,
                            passwordTextEditingController.text,
                          )
                              .then((val) {
                            _controller.uploadUserData(userInfoMap);
                            HelperFunctions.saveAppUserLoggedInSharedPreference(
                                true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom()),
                            );
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
                        "Sign up with Google",
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
                          "Already have account? ",
                          style: mediumTextStyle(),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Sign In",
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
            ),
    );
  }
}
