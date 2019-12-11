import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../public/ToastUtil.dart';
import './service_url.dart';

Future postNet(url, {formData, options, path}) async {
  try {
    print('开始请求……');
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    Response response;
    var token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = await sharedPreferences.getString('token');
    if (token == null) {
    } else {
      dio.options.headers['token'] = token;
    }
    if (options != null) {
      dio.options.headers = options["hearder"];
    }

    if (path == null) {
      if (formData == null) {
        print(servicePath[url]);
        response = await dio.post(servicePath[url]);
      } else {
        response = await dio.post(servicePath[url], data: formData);
        print(response);
      }
    } else {
      if (formData == null) {
        print((servicePath[url] + '/' + path));
        response = await dio.post((servicePath[url] + '/' + path));
      } else {
        response = await dio.post((servicePath[url] + '/' + path), data: formData);
        print(response);
      }

    }

    if (response.statusCode == 200) {
      var responseData = json.decode(response.toString());
      debugPrint('${responseData}返回数据');
      return responseData;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    errorMsg(e);
    if (url.toString() == 'login') {
      Toast.show("登陆失败，检查账户或密码");
    } else if (url.toString() == "register") {
      Toast.show("注册失败，检查账户或密码");
    }
  }
}

//put请求
Future putNet(url, {formData, options}) async {
  try {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    //设置连接超时时间
    dio.options.connectTimeout = 10000;
    //设置数据接收超时时间
    dio.options.receiveTimeout = 10000;
//    print(formData.toString());
    Response response;
    var token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = await sharedPreferences.getString('token');
    if (token == null) {
    } else {
      dio.options.headers['token'] = token;
    }

//    print(formData);
//    print(dio.options.headers);

    if (options != null) {
      dio.options.headers = options["hearder"];
    }
    if (formData == null) {
      response = await dio.put(servicePath[url]);
    } else {
      response = await dio.put(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      //防止打印日志不全。
      var responseData = json.decode(response.toString());

      debugPrint('${responseData}______put返回数据');
      return responseData;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    errorMsg(e);
    if (url.toString() == 'login') {
      Toast.show("登陆失败，检查账户或密码");
    } else if (url.toString() == "register") {
      Toast.show("注册失败，检查账户或密码");
    } else {
      Toast.show("错误检查信息");
    }
  }
}

//get请求
Future getNet(url, {data, path}) async {
  try {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    //设置连接超时时间
    dio.options.connectTimeout = 10000;
    //设置数据接收超时时间
    dio.options.receiveTimeout = 10000;
//    print(data.toString());
    Response response;
    var token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = await sharedPreferences.getString('token');
    if (token == null) {
    } else {
      dio.options.headers['token'] = token;
    }
    if (path == null) {
      print((servicePath[url]));
      if (data == null) {
        response = await dio.get((servicePath[url]));
      } else {
        response = await dio.get((servicePath[url]), queryParameters: data);
        print(response);
      }
    } else {
      print((servicePath[url] + '/' + path));

      if (data == null) {
        response = await dio.get((servicePath[url] + '/' + path));
      } else {
        response = await dio.get((servicePath[url] + '/' + path), queryParameters: data);
        print(response);
      }
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
    errorMsg(e);
  }
}

void errorMsg(e) {
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
}
