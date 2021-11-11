import 'package:flutter/material.dart';
import '../widgets/constants.dart';

Widget mainAppBar(BuildContext context) {
  return AppBar(
    title: Text(UniversalConstant.APP_NAME),
    backgroundColor: Colors.grey[800],
    centerTitle: true,
  );
}

// For AppBar
Widget myAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.grey[800],
    centerTitle: true,
  );
}

// For Text Field Decoration
InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(),
    focusedBorder: UnderlineInputBorder(),
    enabledBorder: UnderlineInputBorder(),
  );
}

// For text style
TextStyle simpleTextStyle() {
  return TextStyle(
    // color: Colors.white,
    fontSize: 14.0,
  );
}

TextStyle mediumTextStyle() {
  return TextStyle(
    fontSize: 16.0,
  );
}

TextStyle mediumTextStyleWhiteColor() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16.0,
  );
}
