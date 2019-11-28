import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SpUtil{
  static SharedPreferences preferences;
  static Future<bool> getInstance() async{
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  static SharedPreferences getSp(){
    return preferences;
  }

}
class GlobalConfig {
  static bool dark = true;
  static Color searchBackgroundColor = Color(0xFFEBEBEB);
  static Color cardBackgroundColor = Colors.white;
  static Color fontColor = Colors.black54;
}

Future getString() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  return token;
}