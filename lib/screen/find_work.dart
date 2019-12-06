import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FindWork extends StatefulWidget{
  _FindWork createState() => _FindWork();
}

class _FindWork extends State<FindWork>{
  WebViewController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: "http://job.zhinanche.com/mobile/#/baseInfo",
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