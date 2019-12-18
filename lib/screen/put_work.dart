import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PutWork extends StatefulWidget{
  _PutWork createState() => _PutWork();
}

class _PutWork extends State<PutWork>{
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebView(
          initialUrl: "http://127.0.0.1:8080/#/orderIndex",
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
            _controller.evaluateJavascript("document.title").then((result){
              print('加载完成');
            }
            );
          },
        )
    );
  }
}