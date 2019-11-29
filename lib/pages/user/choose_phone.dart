import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app_test/service/service_method.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';

class ChoosePhone extends StatefulWidget {
  @override
  _ChoosePhoneState createState() => _ChoosePhoneState();
}

class _ChoosePhoneState extends State<ChoosePhone> {

  TextEditingController phone = new TextEditingController();
  TextEditingController newPass = new TextEditingController();
  TextEditingController code = new TextEditingController();
  TextEditingController surePass = new TextEditingController();
  TextEditingController oldPass = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
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
                child: forgetPass()),
          ],
        ),
      ),
    );
  }

  Widget  forgetPass(){
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
              controller: phone,
              decoration: InputDecoration(
                  hintText: "输入手机号",
                  icon: Icon(
                    Icons.phone_android,
                    color: Color(0xff477BFF),
                  )),
              // 校验用户名
              validator: (v) {
                return v.trim().length == 11? null: "请填写正确手机号";
              },
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
                            Icons.assignment_turned_in,
                            color: Color(0xff477BFF),
                          )),
                      // 验证码
                      validator: (v) {
//                        if (!visible) {
                        return phone.text.length > 0
                            ? v.trim().length == 6 ? null : '请输入6位验证码'
                            : "手机号不能为空";
//                        } else {
//                          return null;
//                        }
                      },
                    ),
                    Align(
                      alignment: FractionalOffset.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            _getSms();
                          },
                          child: Text('获取验证码',style: TextStyle(color: Color(0xFF477BFF)),),
                        ),
                      ),
                    )
                  ],
                )),
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
                        child: Text("确认修改",
                            style: TextStyle(fontSize: ScreenUtil().setSp(32))),
                        textColor: Colors.white,
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        onPressed: (){
                          if ((_formKey.currentState as FormState).validate()) {
//                              print('a');
                            putNet("choosePhone",formData: new FormData.from({
                              "username": phone.text,
                            }),
                                options: {
                                  "hearder": {'code': code.text, 'send': phone.text}
                                }).then((res){
                              if(res["result"]==1){
                                Toast.show("修改成功");
                                Navigator.pop(context);
                              }
                            });
                          }
                        }),
                  )
                ],
              ),
            )
          ],
        ));
  }
  //获取验证码
  void _getSms() {
    if (phone.text.length == 11) {
      FormData formData = new FormData.from({
        'send': phone.text,
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
