import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PutWork extends StatefulWidget {
  _PutWork createState() => _PutWork();
}

class _PutWork extends State<PutWork> {
  WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//  Future getUserMsg() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//      var token = sharedPreferences.get('token');
//      return token;
//      print('webview token is ${token}');
//  }
//
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    getUserMsg();
//  }
  //兼职
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebView(
      initialUrl: "http://test.zhinanche.com/service/mobile/#/orderIndex",
      //JS执行模式 是否允许JS执行
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        _controller = controller;
      },
      navigationDelegate: (NavigationRequest request) {
        print("url is ${request.url}");
        // 判断URL
        if (request.url.startsWith('https://www.baidu.com')) {
          // 做一些事情
          // 阻止进入登录页面
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
//        加载完成的回调
      onPageFinished: (url) {
        _controller.evaluateJavascript("document.title").then((result) {
          print('加载完成');
        });
      },
      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(
            name: "share",
            onMessageReceived: (JavascriptMessage message) {
              print("参数： ${message.message}");
            }),
      ].toSet(),
    )

//        FutureBuilder(
//          future: getUserMsg(),
//          builder: (context,sna){
//            print('sna is ${sna}');
//            if(sna.hasData){
//              return
//                WebView(
//                initialUrl: "http://test.zhinanche.com/service/mobile/#/orderIndex?token=${sna.data}",
//                //JS执行模式 是否允许JS执行
//                javascriptMode: JavascriptMode.unrestricted,
//                onWebViewCreated: (controller) {
//                  _controller = controller;
//                },
//                navigationDelegate: (NavigationRequest request) {
//                  print("url is ${request.url}");
//                  // 判断URL
//                  if (request.url.startsWith('orderIndex')) {
//                    Toast.show('调用');
//                  }
//                  return NavigationDecision.navigate;
//                },
//                onPageFinished: (url) {
//                  _controller.evaluateJavascript("document.title").then((result) {
//                  }
//                  );
//                },
//              );
//            }else{
//              return
//                WebView(
//                initialUrl: "http://test.zhinanche.com/service/mobile/#/orderIndex",
//                //JS执行模式 是否允许JS执行
//                javascriptMode: JavascriptMode.unrestricted,
//                onWebViewCreated: (controller) {
//                  _controller = controller;
//                },
//                onPageFinished: (url) {
//                  _controller.evaluateJavascript("document.title").then((result) {
//                  }
//                  );
//                },
//              );
//            }
//          },
//
        );
  }
}
