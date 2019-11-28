import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';

//import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../public/ToastUtil.dart';

//import 'dart:async';
import './service_url.dart';

Future postNet(url, {formData, options}) async {
  try {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    //设置连接超时时间
    dio.options.connectTimeout = 10000;
    //设置数据接收超时时间
    dio.options.receiveTimeout = 10000;
    print(formData.toString());
    Response response;
    var token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = await sharedPreferences.getString('token');
    if (token == null) {
    } else {
      dio.options.headers['token'] = token;
    }
    if (options != null) {
      print('_____');
      print(options);
      dio.options.headers = options["hearder"];
    }
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      //防止打印日志不全。
      var responseData = json.decode(response.toString());

      debugPrint('${responseData}返回数据');
      return responseData;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时${e.type}");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时${e.type}");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时${e.type}");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常${e}");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消${e.type}");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
    if(url.toString()=='login'){
      Toast.show("登陆失败，检查账户或密码");
    }else if(url.toString()=="register"){
      Toast.show("注册失败，检查账户或密码");
    }

  }
}

Future getNet(url, {formData}) async {
  try {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    //设置连接超时时间
    dio.options.connectTimeout = 10000;
    //设置数据接收超时时间
    dio.options.receiveTimeout = 10000;
    print(formData.toString());
    Response response;
    var token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = await sharedPreferences.getString('token');
    if (token == null) {
    } else {
      dio.options.headers['token'] = token;
    }

    if (formData == null) {
      response = await dio.get((servicePath[url]));
    } else {
      response = await dio.get((servicePath[url]));
    }

    if (response.statusCode == 200) {
      //防止打印日志不全。
      var responseData = json.decode(response.toString());

//      debugPrint('${responseData}返回数据');
      return responseData;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
