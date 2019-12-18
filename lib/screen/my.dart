import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';
import '../routers/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider/base_list_provider.dart'; //状态管理器
import 'package:shared_preferences/shared_preferences.dart';
import '../index-page.dart';
import 'dart:convert';
import '../service/service_method.dart';
import '../pages/user/user_msg.dart';
import '../public/base.dart';

class MyPage extends StatefulWidget {
  _MyPage createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  var token;
  bool isLogin = false;
  var usermsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 这里可以进行请求初始化和弹框提示
    print('didChangeDependencies');
    getUserMsg();
  }

  Future getUserMsg() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.get('token');
//      print('token is ${token}');
      isLogin = token == null ? false : true;
      print('mypage是否登录${isLogin}');
      if (isLogin) {
        getNet('getUserMsg').then((res) {
          if (res['result'] == 1) {
            setState(() {
              usermsg = res['data'];
            });
          }
        });
      }
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _getLoginInfo();
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(720.0),
          height: ScreenUtil().setHeight(500.0),
          child: Stack(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(720.0),
                height: ScreenUtil().setHeight(383.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/user_bg.png'),
                        fit: BoxFit.cover)),
                child: Container(
                  height: ScreenUtil().setHeight(117.0),
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(38.0)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(120),
                        height: ScreenUtil().setWidth(120),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(60.0)),
                            image: DecorationImage(
                                image: isLogin
                                    ? usermsg['head_img'] != null
                                    ? NetworkImage(usermsg['head_img'])
                                    : AssetImage(
                                    'assets/image/not_login.png')
                                    : AssetImage(
                                    'assets/image/not_login.png'),
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                if (isLogin) {
//                          Application.router.navigateTo(context,
//                              '/userMsgPage?userMsg=${Uri.encodeComponent(widget.userMsg.toString())}');
                                } else {
                                  print('jump');
                                  Application.router
                                      .navigateTo(context, '/loginPage');
                                }
                              },
                              child: Container(
                                height: ScreenUtil().setHeight(135.0),
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(20.0)),
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(10.0),
                                    bottom: ScreenUtil().setHeight(10.0)),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      isLogin
                                          ? usermsg['name'] == null
                                          ? '指南车'
                                          : usermsg['name']
                                          : '登录/注册',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(38.0)),
                                    ),
                                    Text(
                                        isLogin
                                            ? usermsg['phone'] == null
                                            ? '手机号码'
                                            : usermsg['phone']
                                            : '请先登录或注册',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                            ScreenUtil().setSp(32.0)))
                                  ],
                                ),
                              ))),
                      Container(
                        child: Text(
                          '邀请好友',
                          style: TextStyle(
                              color: Color(0xFFB48403),
                              fontSize: ScreenUtil().setSp(28.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(24.0),
                          ScreenUtil().setHeight(8.0),
                          ScreenUtil().setHeight(24.0),
                          ScreenUtil().setHeight(8.0),
                        ),
                        // height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFF26E), Color(0xFFFFD025)]),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
              Positioned(
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: _btnGroup(),
                ),
                top: ScreenUtil().setHeight(304),
              )
            ],
          ),
        ),
        Container(
//          height: ScreenUtil().setHeight(157.0),
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(20)),
          child: InkWell(
            onTap: () {
              if(token==null){
                Toast.show("请先登录");
              }else{
                Application.router.navigateTo(context, '/inviteFriendPage');
              }
            },
            child: Image.asset(
              'assets/image/invite.png',
              width: ScreenUtil().setWidth(720),
            ),
          ),
        ),
        Expanded(
         child: Container(
           padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30.0)),
           child: Column(
             children: <Widget>[
               _pageStrip('user_znc', '/aboutUsPage', '关于我们'),
               _pageStrip('user_write', '/feedBackPage', '意见反馈'),
               _pageStrip('user_up', '/updatePage', '版本更新'),
               _pageStrip('user_manage', '/aboutUs', '退出登录'),
             ],
           ),
         ),
        ),
      ],
    );
  }

//拼装按钮栏
  Container _btnGroup() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//      margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      width: ScreenUtil().setWidth(700.0),
//      height: ScreenUtil().setHeight(190),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buttonIcon('/userMsgPage', 'assets/image/user_massage.png', '个人信息'),
          _buttonIcon(
              '/newsCenterPage', 'assets/image/massage_center.png', '消息中心'),
          _buttonIcon(
              '/inviteFriendPage', 'assets/image/my_visite.png', '我的邀请'),
          _buttonIcon('aa', 'assets/image/my_cert.png', '我的认证'),
        ],
      ),
    );
  }

  // 按钮栏
  Container _buttonIcon(String route, String img, String label) {
    return Container(
//      width: ScreenUtil().setWidth(150.0),
      child: InkWell(
          onTap: () {
            if(token==null){
              Toast.show("请先登录");
            }else{
              print('click');
              if (route == "/userMsgPage") {
                dynamic userDtat = {
                  "id": usermsg["id"],
                  "header_img": usermsg['head_img'],
                  "name": usermsg["name"],
                  "sex": usermsg['sex'],
                  "phone": usermsg['phone']
                };
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserMsgPage(userDtat)));
              } else {
                Application.router.navigateTo(context, route);
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(
                img,
                width: ScreenUtil().setWidth(110),
              ),
              Container(
                child: Text(
                  label,
                  style: TextStyle(
                      color: Color(0xFF5C6784),
                      fontSize: ScreenUtil().setSp(28.0)),
                ),
                margin: EdgeInsets.only(top: 5),
              )
            ],
          )),
    );
  }

//  底部页面跳转栏
  Container _pageStrip(String img, String router, String label) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          print('jump');
          print(router);
          if (label == '退出登录') {
            if (isLogin) {
              showLogoutDialog();
            }
          } else {
            Application.router.navigateTo(context, router);
          }
        },
        child: Row(children: <Widget>[
          Image.asset('assets/image/${img}.png',
              width: ScreenUtil().setWidth(42.0),
              height: ScreenUtil().setHeight(42.0)
          ),
          Expanded(
              child: Container(
            child: Text(
              label,
              style: TextStyle(
                  color: Color(0xFF5C6784), fontSize: ScreenUtil().setSp(30.0)),
            ),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(10.0)),
          )),
          Image.asset('assets/image/go_last.png',
              width: ScreenUtil().setWidth(14.0))
        ]),
      ),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      color: Colors.white,
    );
  }

//弹出提示是否退出登录
  void showLogoutDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('确认退出吗？'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('取消', style: TextStyle(color: Color(0xff212121))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                removeString();
                setState(() {
                  usermsg = new Map();
                });

                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ZncIndexPage()));
              },
            ),
          ],
        );
      },
    );
  }

  _getLoginInfo() async {
    if (SpUtil.getSp() != null) {
      token = SpUtil.getSp().get('token');
    }
  }
}

Future removeString() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove('token');
}

// 用户登录栏 邀请好友
class UserTop extends StatefulWidget {
  bool isLogin;
  var userMsg;

  UserTop(this.isLogin, this.userMsg);

  @override
  _UserTopState createState() => _UserTopState();
}

//构建个人信息  消息中心。。
class _UserTopState extends State<UserTop> {
  @override
  Widget build(BuildContext context) {
//    print(widget.userMsg);
    return Container(
      width: ScreenUtil().setWidth(720.0),
      height: ScreenUtil().setHeight(450.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/user_bg.png'),
              fit: BoxFit.cover)),
      child: Container(
        height: ScreenUtil().setHeight(150.0),
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(38.0)),
        child: Center(
          child: Row(
            children: <Widget>[
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(70.0)),
                    image: DecorationImage(
                        image: widget.isLogin
                            ? widget.userMsg['head_img'] != null
                                ? NetworkImage(widget.userMsg['head_img'])
                                : AssetImage('assets/image/not_login.png')
                            : AssetImage('assets/image/not_login.png'),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        print('aa');
                        if (widget.isLogin) {
                          print('user');
                          dynamic userDtat = {
                            "id": widget.userMsg["id"],
                            "header_img": widget.userMsg['head_img'],
                            "name": widget.userMsg["name"],
                            "sex": widget.userMsg['sex'],
                            "phone": widget.userMsg['phone']
                          };
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserMsgPage(userDtat)));
                        } else {
                          print('jump');
                          Application.router.navigateTo(context, '/loginPage');
                        }
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(135.0),
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10.0),
                            bottom: ScreenUtil().setHeight(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.isLogin
                                  ? widget.userMsg['name'] == null
                                      ? '指南车'
                                      : widget.userMsg['name']
                                  : '登录/注册',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(38.0)),
                            ),
                            Text(
                                widget.isLogin
                                    ? widget.userMsg['phone'] == null
                                        ? '手机号码'
                                        : widget.userMsg['phone']
                                    : '请先登录或注册',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(32.0)))
                          ],
                        ),
                      ))),
              Container(
                child: Text(
                  '邀请好友',
                  style: TextStyle(
                      color: Color(0xFFB48403),
                      fontSize: ScreenUtil().setSp(28.0)),
                ),
                padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(24.0),
                  ScreenUtil().setHeight(8.0),
                  ScreenUtil().setHeight(24.0),
                  ScreenUtil().setHeight(8.0),
                ),
                // height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFF26E), Color(0xFFFFD025)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
