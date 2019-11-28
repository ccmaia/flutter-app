import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes{
  static String root='/';
  static String eachPage = '/eachPage';
  static String searchPage = '/searchPage';
  static String loginPage = '/loginPage';
  static String userMsgPage = '/userMsgPage';
  static String aboutUsPage = '/aboutUsPage';
  static String feedBackPage = '/feedBackPage';

  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
      }
    );

    router.define(eachPage,handler:eachPageHanderl);
    router.define(searchPage,handler:searchPageHanderl);
    router.define(loginPage, handler: loginPageHanderl);
    router.define(userMsgPage, handler: userMsgPageHanderl);
    router.define(aboutUsPage, handler: AboutUsPageHanderl);
    router.define(feedBackPage, handler: FeedBackPageHanderl);
  }

}
