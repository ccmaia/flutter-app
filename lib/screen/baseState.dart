import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/httpUtils.dart';

abstract class BaseState<T> extends State<StatefulWidget> implements HttpCallBack{

  void onTabSelected(bool selected){
    //当前页面选中的回调  需要刷新的重写该方法
  }

  void callback(bool success,Object obj,{Object type}){
    //网络请求回调
  }
}