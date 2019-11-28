import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/each_view.dart';
import '../pages/search_page.dart';
import '../pages/user/login.dart';
import '../pages/user/user_msg.dart';
import '../pages/user/about_us.dart';
import '../pages/user/feed_back.dart';

Handler AboutUsPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutUsPage();
});
Handler FeedBackPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FeedBackPage();
});
Handler searchPageHanderl =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return SearchPage();
  }
);
Handler eachPageHanderl =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String data = params['data'].first;
    print('data is ${data}');
    return EachView(data);
  }
);
Handler loginPageHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return LoginPage();
    }
);
Handler userMsgPageHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      print(params);
      Map data = params;
      return UserMsgPage(data);
    }
);