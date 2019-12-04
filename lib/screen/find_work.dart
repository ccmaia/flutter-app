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
        initialUrl: "https://job.zhinanche.com/mobile/#/baseInfo",
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
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