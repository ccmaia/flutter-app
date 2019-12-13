import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';

class PersonalCenterPage extends StatefulWidget {
  @override
  _PersonalCenterPageState createState() {
    return new _PersonalCenterPageState();
  }
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {

  var token = null;
  bool isLogin = false;
  var userInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserMsg();
  }

  Future getUserMsg() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.get('token');
//      print('token is ${token}');
      isLogin = token == null ? false : true;
      if (isLogin) {
        getNet('getUserMsg').then((res) {
          print(res);
          if (res['result'] == 1) {
            setState(() {
              userInfo = res['data'];
            });
          }
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Stack(
          children: <Widget>[
            Image.asset('assets/image/invite-bg.png'),
            Positioned(
              bottom: -1,
              left: 0,
              right: 0,
              child: Container(
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(16.0)),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(140),
                        height: ScreenUtil().setHeight(140),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(70.0)),
                            image: DecorationImage(
                                image:null!= userInfo ? NetworkImage( userInfo['head_img']):AssetImage('assets/image/not_login.png'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(62.0)),
                        child: Text(
                           null!=userInfo?'${userInfo['name']}':'机器人',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(35.0),
                              color: Colors.white,
                              height: 2.5),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      child: Column(
                        children: <Widget>[
                          Divider(
                            height: ScreenUtil().setSp(20.0),
                            color: Color.fromRGBO(240, 240, 240, 1),
                          ),
                          InkWell(
                            onTap: () {
                              Application.router
                                  .navigateTo(context, '/myArticlePage');
                            },
                            child: Container(
//                              height: ScreenUtil().setHeight(90.0),
                              padding:
                                  EdgeInsets.all(ScreenUtil().setWidth(38.0)),
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Image.asset('assets/image/my_1.png',
                                      width: ScreenUtil().setWidth(39.0),
                                      height: ScreenUtil().setHeight(39.0)),
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      '我的发帖',
                                      style: TextStyle(
                                          color: Color(0xFF5C6784),
                                          fontSize: ScreenUtil().setSp(30.0)),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(15.0)),
                                  )),
                                  Image.asset('assets/image/go_last.png',
                                      width: ScreenUtil().setWidth(14.0))
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Application.router
                                  .navigateTo(context, '/myReplyPage');
                            },
                            child: Container(
//                              height: ScreenUtil().setHeight(90.0),
                              padding:
                                  EdgeInsets.all(ScreenUtil().setWidth(38.0)),
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Image.asset('assets/image/my_2.png',
                                      width: ScreenUtil().setWidth(39.0),
                                      height: ScreenUtil().setHeight(39.0)),
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      '我的回帖',
                                      style: TextStyle(
                                          color: Color(0xFF5C6784),
                                          fontSize: ScreenUtil().setSp(30.0)),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(15.0)),
                                  )),
                                  Image.asset('assets/image/go_last.png',
                                      width: ScreenUtil().setWidth(14.0))
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Application.router
                                  .navigateTo(context, '/newsCenterPage');
                            },
                            child: Container(
//                              height: ScreenUtil().setHeight(90.0),
                              padding:
                                  EdgeInsets.all(ScreenUtil().setWidth(38.0)),
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Image.asset('assets/image/my_3.png',
                                      width: ScreenUtil().setWidth(39.0),
                                      height: ScreenUtil().setHeight(39.0)),
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      '互动消息',
                                      style: TextStyle(
                                          color: Color(0xFF5C6784),
                                          fontSize: ScreenUtil().setSp(30.0)),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(15.0)),
                                  )),
                                  Image.asset('assets/image/go_last.png',
                                      width: ScreenUtil().setWidth(14.0))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
