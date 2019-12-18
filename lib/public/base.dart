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
  static Future isLogin() async{
    var token;
    if(SpUtil.getSp()!=null){
      token = SpUtil.getSp().get('token');
    }
    print('token is ${token}');
    return token;
  }

}
class GlobalConfig {
  static bool dark = true;
  static Color searchBackgroundColor = Color(0xFFEBEBEB);
  static Color cardBackgroundColor = Colors.white;
  static Color fontColor = Colors.black54;
  static Color bgColor1 = Color(0xFFF9F9F9);//通用背景颜色
  static Color bgColor2 = Color(0xFFEFEFEF);
//  static Color serif1 = Color(0x)
}
//  判断是否有token是否登录
Future getString() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  return token;
}



