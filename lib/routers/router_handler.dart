import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/each_view.dart';
import '../pages/search_page.dart';
import '../pages/user/login.dart';
import '../pages/user/user_msg.dart';
import '../pages/user/about_us.dart';
import '../pages/user/feed_back.dart';
import '../pages/user/invite_friend.dart';
import '../pages//user/forget_pass.dart';
import '../pages//user/choose_password.dart';
import '../pages/user/choose_phone.dart';
import '../pages/community/news_center.dart';
import '../pages/user/update.dart';

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
Handler InviteFriendPageHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return InviteFriendPage();
    }
);
Handler forgetPassHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return ForgetPassword();
    }
);
Handler choosePassHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String data = params['phone'].first;
      return ChoosePass(data);
    }
);
Handler choosePhoneHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return ChoosePhone();
    }
);
Handler newsCenterHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return NewsCenterPage();
    }
);
Handler updatePageHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return UpdatePage();
    }
);