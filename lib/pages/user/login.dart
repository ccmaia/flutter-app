import 'package:flutter/material.dart';
import 'package:flutter_app_test/routers/application.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provider/base_list_provider.dart';
import '../../service/service_method.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../index-page.dart';
import '../../public/ToastUtil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String btnText = "登录";
  String bottomText = "立即注册";
  bool visible = true;
  TextEditingController unameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController code = new TextEditingController();
  TextEditingController shareCode = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(750.0),
              height: ScreenUtil().setHeight(402.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/login_bg.png'),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              child: Image.asset(
                'assets/image/znc_logo.png',
                width: ScreenUtil().setWidth(334),
                height: ScreenUtil().setHeight(61),
              ),
              top: ScreenUtil().setHeight(197),
              left: ScreenUtil().setWidth(208),
//                left: 208,
            )
          ],
        ),
        Container(
//          height: ScreenUtil().setHeight(932),
            color: Colors.white,
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(68.0),
                top: ScreenUtil().setHeight(88.0),
                right: ScreenUtil().setWidth(68.0)),
            child: visible ? loginBuildForm() : registerBuildForm()),
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(80.0),
                bottom: ScreenUtil().setHeight(30.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "忘记密码",
                    style: TextStyle(
                        color: Color(0xFF477BFF),
                        fontSize: ScreenUtil().setSp(30)),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {},
                ),
                Container(
                  width: 2.0,
                  color: Color(0xFF477BFF),
                  height: ScreenUtil().setHeight(26.0),
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                ),
                GestureDetector(
                  child: Text(
                    bottomText,
                    style: TextStyle(
                        color: Color(0xFF477BFF),
                        fontSize: ScreenUtil().setSp(30)),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    setState(() {
                      if (visible) {
                        btnText = "注册";
                        visible = false;
                        bottomText = "立即登录";
                      } else {
                        btnText = "登录";
                        visible = true;
                        bottomText = "立即注册";
                      }
                    });
                  },
                ),
              ],
            ))
      ],
    ));
  }

  void _bottonLogin() async {
    print(visible);
    if (visible) {
      //登录
      if ((_formKey.currentState as FormState).validate()) {
        FormData formData = new FormData.from({
          'username': unameController.text,
          'password': pwdController.text,
          'status': 2
        });
        postNet('login', formData: formData).then((val) {
          if (val['result'] == 1) {
            Toast.show('登录成功');
            _saveLoginStatus(val['data']);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ZncIndexPage()),
              (route) => route == null,
            ).then((data) {


              setState(() {});
            });
          } else {
            Application.router.navigateTo(context, '');
            showDialog(
                context: context,
                builder: (context) => AlertDialog(title: Text('登录失败，请重新登录')));
          }
        });
      } else {}
    } else {
      //注册
      postNet('register',
          formData: new FormData.from({
            "username": unameController.text,
            "password": pwdController.text,
            "origin": "app"
          }),
          options: {
            "hearder": {'code': code.text, 'send': unameController.text}
          }).then((res) {
        if (res['result'] == 1) {
          Toast.show("注册成功");
          setState(() {
            visible = true;
            btnText = "登录";
            bottomText = "立即注册";
          });
        }
//        code.
      });
    }
  }

  void _saveLoginStatus(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data.toString());
    print('login success_____________________');
  }

  Widget loginBuildForm() {
    return Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              //键盘回车键的样式
              textInputAction: TextInputAction.next,
              controller: unameController,
              decoration: InputDecoration(
                  hintText: "您的手机号码",
                  icon: Icon(
                    Icons.phone_android,
                    color: Color(0xff477BFF),
                  )),
              // 校验用户名
              validator: (v) {
                return v.trim().length > 0 || v.trim().length <= 11
                    ? null
                    : "请填写手机号";
              },
            ),
            TextFormField(
              autofocus: false,
              obscureText: true,
              textInputAction: TextInputAction.next,
              controller: pwdController,
              decoration: InputDecoration(
                  hintText: "您的登录密码",
                  icon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff477BFF),
                  )),
//               校验密码
//              validator: (v) {
//                return v.trim().length > 5 ? null : "密码不能少于6位";
//              },
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(28.0)),
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(452),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(80.0)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF36A4F2), Color(0xFF2A5CF6)]),
                    ),
                    child: RaisedButton(
                        color: Colors.transparent,
//                        padding: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
                        child: Text(btnText,
                            style: TextStyle(fontSize: ScreenUtil().setSp(32))),
                        textColor: Colors.white,
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        onPressed: _bottonLogin),
//                    alignment: Alignment.center,
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget registerBuildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              //键盘回车键的样式
              textInputAction: TextInputAction.next,
              controller: unameController,
              decoration: InputDecoration(
                  hintText: "输入手机号",
                  icon: Icon(
                    Icons.phone_android,
                    color: Color(0xff477BFF),
                  )),
            ),
            Container(
                child: Stack(
              children: <Widget>[
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  //键盘回车键的样式
                  textInputAction: TextInputAction.next,
                  controller: code,
                  decoration: InputDecoration(
                      hintText: "输入验证码",
                      icon: Icon(
                        Icons.lock_outline,
                        color: Color(0xff477BFF),
                      )),
                  // 验证码
                  validator: (v) {
                    print(unameController);
                    if (!visible) {
                      return unameController.text.length > 0
                          ? v.trim().length > 0 ? null : '验证码不能为空'
                          : "手机号不能为空";
                    } else {
                      return null;
                    }
                  },
                ),
                Align(
                  alignment: FractionalOffset.centerRight,
                  child: Container(
//                      height: ScreenUtil().setHeight(50),
                    decoration: BoxDecoration(
//                        border: new Border.all(color: Colors.blueAccent, width: 1),
                        ),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        _getSms();
                      },
                      child: Text('获取验证码'),
                    ),
                  ),
                )
              ],
            )),
            TextFormField(
              autofocus: false,
              obscureText: false,
              keyboardType: TextInputType.number,
              //键盘回车键的样式
              textInputAction: TextInputAction.next,
              controller: pwdController,
              decoration: InputDecoration(
                  hintText: "输入密码",
                  icon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff477BFF),
                  )),
            ),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              //键盘回车键的样式
              textInputAction: TextInputAction.next,
              controller: shareCode,
              decoration: InputDecoration(
                  hintText: "输入邀请码（非必填）",
                  icon: Icon(
                    Icons.person_pin,
                    color: Color(0xff477BFF),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(33.0)),
              child: Row(
                children: <Widget>[
                  Text(
                    '新用户注册，代表同意',
                    style: TextStyle(color: Color(0xFF999999)),
                  ),
                  Text(
                    '<<指南车用户协议>>',
                    style: TextStyle(color: Color(0xFF477BFF)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(60.0)),
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(452),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(80.0)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF36A4F2), Color(0xFF2A5CF6)]),
                    ),
                    child: RaisedButton(
                        color: Colors.transparent,
//                        padding: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
                        child: Text(btnText,
                            style: TextStyle(fontSize: ScreenUtil().setSp(32))),
                        textColor: Colors.white,
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        onPressed: _bottonLogin),
//                    alignment: Alignment.center,
                  )
                ],
              ),
            )
          ],
        ));
  }

  //获取验证码
  void _getSms() {
    if (unameController.text.length == 11) {
      FormData formData = new FormData.from({
        'send': unameController.text,
      });
      postNet('getSMS', formData: formData).then((res) {
        if (res['result'] == 1) {
          Toast.show("验证码发送成功");
        }
      });
    } else {
      Toast.show('请填写正确手机号');
    }
  }
}
