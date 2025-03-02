import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes{
  static String root='/';
  static String searchPage = '/searchPage';
  static String loginPage = '/loginPage';
  static String userMsgPage = '/userMsgPage';
  static String aboutUsPage = '/aboutUsPage';
  static String feedBackPage = '/feedBackPage';
  static String inviteFriendPage = '/inviteFriendPage';
  static String forgetPassword = "/forgetPassPage";
  static String choosePassword = "/choosePassPage";
  static String choosePhone = "/choosePhonePage";
  static String updatePage = "/updatePage";


  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('错误===>未找到路由!!!');
      }
    );

    router.define(searchPage,handler:searchPageHanderl);
    router.define(loginPage, handler: loginPageHanderl);
    router.define(userMsgPage, handler: userMsgPageHanderl);
    router.define(aboutUsPage, handler: AboutUsPageHanderl);
    router.define(feedBackPage, handler: FeedBackPageHanderl);
    router.define(inviteFriendPage, handler: InviteFriendPageHanderl);
    router.define(forgetPassword, handler: forgetPassHanderl);
    router.define(choosePassword, handler: choosePassHanderl);
    router.define("/choosePhonePage", handler: choosePhoneHanderl);
    router.define("/newsCenterPage", handler: newsCenterHanderl);
    router.define(updatePage,handler:updatePageHanderl);
    router.define("/choosethreadTypePage",handler:choosethreadTypePageHanderl);
    router.define("/putThreadPage",handler:putthreadPageHanderl);
    router.define("/articleDetailPage", handler: articleDetailHanderl);
    router.define("/personalCenterPage", handler: personalCenterHanderl);
    router.define("/myArticlePage", handler: myArticlePageHanderl);
    router.define("/myReplyPage", handler: myReplyPageHanderl);
    router.define("/certifyIndexPage", handler: certifyIndexHanderl);
    router.define("/registerPage", handler: registerHanderl);
    router.define("/inquirePage", handler: inquireHanderl);


  }

}
