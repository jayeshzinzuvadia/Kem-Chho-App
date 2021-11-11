import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferencedUserLoggedInKey = "IS_LOGGED_IN";
  static String sharedPreferencedUserNameKey = "USER_NAME_KEY";
  static String sharedPreferencedUserEmailKey = "USER_EMAIL_KEY";

  // Saving data to Shared Preference
  static Future<void> saveAppUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(
        sharedPreferencedUserLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveAppUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencedUserNameKey, userName);
  }

  static Future<void> saveAppUserEmailSharedPreference(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencedUserEmailKey, email);
  }

  // Getting data from SharedPreference
  static Future<bool> getAppUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferencedUserLoggedInKey);
  }

  static Future<String> getAppUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencedUserNameKey);
  }

  static Future<String> getAppUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencedUserEmailKey);
  }
}
