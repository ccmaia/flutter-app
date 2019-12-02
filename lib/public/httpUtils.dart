import 'package:dio/dio.dart';
import 'package:flutter_app_test/service/service_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUtils {

  static CancelToken _cancelToken = new CancelToken();

  static get(String keyUrl, HttpCallBack callback, {type,params,options}) async {
    Dio dio = new Dio();
    type = keyUrl;
    await initToken(dio, options);
    await dio.get(servicePath[keyUrl],queryParameters: params,options: options,cancelToken: _cancelToken).then((Response res) {
      if (res.statusCode == 200) {
        callback.callback(true,res.data,type: type);
      } else {
        callback.callback(false,res.data,type: type);
      }
    });
  }

  static post(String keyUrl, HttpCallBack callback, {type,params,options}) async {
    Dio dio = new Dio();
    type = keyUrl;
    initToken(dio, options);
    await dio.post(servicePath[keyUrl], data: params,options:options, cancelToken: _cancelToken).then((Response res) {
      if (res.statusCode == 200) {
        callback.callback(true,res.data,type: type);
      } else {
        callback.callback(false,res.data,type: type);
      }
    });
  }

  static put(String keyUrl, HttpCallBack callback, {type,params,options}) async {
    Dio dio = new Dio();
    type = keyUrl;
    initToken(dio, options);
    await dio.put(servicePath[keyUrl], data: params,options:options, cancelToken: _cancelToken).then((Response res) {
      if (res.statusCode == 200) {
        callback.callback(true,res.data,type: type);
      } else {
        callback.callback(false,res.data,type: type);
      }
    });
  }

  static cancelAllHttp(){
    _cancelToken.cancel();
  }

  static initToken(Dio dio,options) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = await sharedPreferences.getString('token');
    print('token:'+token);
    if (token == null) {
    } else {
      dio.options.headers['token'] = token;
    }
    if (options != null) {
      dio.options.headers = options["hearder"];
      print(options);
    }
  }
}

abstract class HttpCallBack{
  void callback(bool success,Object obj,{Object type});
}
