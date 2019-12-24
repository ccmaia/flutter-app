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
  static Color fontColor1 = Color(0xFF333333);//通用文字颜色1（深色）
  static Color fontColor2 = Color(0xFF666666);//通用文字颜色1（中等）
  static Color fontColor3 = Color(0xFF999999);//通用文字颜色1（浅色）
  static Color bgColor1 = Color(0xFFF9F9F9);//通用背景颜色 浅
  static Color bgColor2 = Color(0xFFEFEFEF);//通用背景颜色 深
  static Color borderColor1 = Color(0xFFE5E5E5);//通用边框衬线颜色
  static Color primaryColor1 = Color(0xFF2CA0F0);//通用主色调
//  static Color serif1 = Color(0x)
}
//  判断是否有token是否登录
Future getString() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var token = sharedPreferences.get('token');
  return token;
}



