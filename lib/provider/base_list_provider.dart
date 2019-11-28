import 'package:flutter/material.dart';


//状态管理
class Counter with ChangeNotifier {
  bool _isLogin = false ;
  bool get isLogin => _isLogin;
  var userMsg ;
  String _token;

  String get token => _token;

    String _currentIndex;
    String get currentIndex => _currentIndex;
    void ChooseIndex(data){
      _currentIndex = data;
      notifyListeners();
    }


  void loginStatus(){
    _isLogin = !_isLogin;
    notifyListeners();
  }
  void setToken(val){
    _token = val;
    notifyListeners();
  }
}