//import 'package:flutter/material.dart';
//import 'package:fluro/fluro.dart';
//import 'index-page.dart';
//import './pages/user/login.dart';
//import './routers/routes.dart';
//import './routers/application.dart';
//import 'package:provider/provider.dart';
//import './provider/base_list_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//import './screen/community.dart';
//import 'package:oktoast/oktoast.dart';
//void main() {
//  runApp(MyApp());
//}
//
//
//
//class MyApp extends StatelessWidget {
//  var token ;
//
//  void _getLoginInfo() async{
//    SharedPreferences sharedInfo = await SharedPreferences.getInstance();
//    token = sharedInfo.get('token');
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    _getLoginInfo();
//    final router = Router();
//    Routes.configureRoutes(router);
//    Application.router = router;
//    return OKToast(
//      child: MultiProvider(
//        providers: [
//          ChangeNotifierProvider(
//            builder: (_) => Counter(),
//          )
//        ],
//        child: MaterialApp(
//          debugShowCheckedModeBanner: false,
//          title: '指南车',
//          onGenerateRoute: Application.router.generator,
//          theme: ThemeData.light(),
//          home: token==null?LoginPage():ZncIndexPage(),
//          routes: <String,WidgetBuilder>{
//            'homePage':(BuildContext context) => new Community(),//社区
//          },
//        ),
//      ),
//    );
//
//  }
//}

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'index-page.dart';
import './pages/user/login.dart';
import './routers/routes.dart';
import './routers/application.dart';
import 'package:provider/provider.dart';
import './provider/base_list_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screen/community.dart';
import 'package:oktoast/oktoast.dart';

import 'public/base.dart';
void main() {
  runRealApp();
}

runRealApp() async {
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var token ;
  void _getLoginInfo() async{
    if(SpUtil.getSp()!=null){
      token = SpUtil.getSp().get('token');
    }
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    _getLoginInfo();
    print('build start');
    return OKToast(
      radius: 8.0,
      textStyle: TextStyle(fontSize: 16.0,color: Colors.white),
      backgroundColor: Colors.grey..withAlpha(200),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (_) => Counter(),
          )
        ],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('zh', 'CN'),
            const Locale('en', 'US'),
          ],
          debugShowCheckedModeBanner: false,
          title: '指南车',
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
            primaryColor: Colors.grey[100],
            accentColor: Color(0xFF333333),
            indicatorColor: Color(0xFFCCCCCC),
            buttonColor: Colors.transparent,

          ),
          home: token==null?LoginPage():ZncIndexPage(),
          routes: <String,WidgetBuilder>{
            'homePage':(BuildContext context) => new Community(),//社区
          },
        ),
      ),
    );

  }
}

