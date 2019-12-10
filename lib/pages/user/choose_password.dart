import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app_test/service/service_method.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';

class ChoosePass extends StatefulWidget {
  String phone;
  ChoosePass(this.phone);
  @override
  _ChoosePassState createState() => _ChoosePassState();
}

class _ChoosePassState extends State<ChoosePass> {

  TextEditingController phone = new TextEditingController();
  TextEditingController newPass = new TextEditingController();
  TextEditingController surePass = new TextEditingController();
  TextEditingController oldPass = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone.text = widget.phone;
    print("${widget.phone} 手机号");
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
//            Container(
//              height: ScreenUtil().setHeight(1050.0),
//              child: Stack(
//                children: <Widget>[
//                  Container(
//                    width: ScreenUtil().setWidth(720.0),
//                    height: ScreenUtil().setHeight(383.0),
//                    decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: AssetImage('assets/image/login_bg.png'),
//                            fit: BoxFit.cover)),
//                  ),
//                  Positioned(
//                    child: Image.asset(
//                      'assets/image/znc_logo.png',
//                      width: ScreenUtil().setWidth(334),
//                      height: ScreenUtil().setHeight(61),
//                    ),
//                    top: ScreenUtil().setHeight(160),
//                    left: ScreenUtil().setWidth(193),
//                  ),
//                  Positioned(
//                      top: ScreenUtil().setHeight(304),
//                      left: 20,
//                      child: Container(
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(10.0),
//                          color: Colors.white,
//                        ),
//                        padding: EdgeInsets.all(20),
////                    margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
//                        width: ScreenUtil().setWidth(640),
//                        child: forgetPass(),
//                      ))
//                ],
//              ),
//            ),
            Stack(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(720.0),
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
                  top: ScreenUtil().setHeight(160),
                  left: ScreenUtil().setWidth(193),
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
            TextFormField(
              autofocus: false,
              obscureText: true,
              textInputAction: TextInputAction.next,
              controller: oldPass,
              decoration: InputDecoration(
                  hintText: "输入旧密码",
                  icon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff477BFF),
                  )),
              validator: (val){
                return val.length<6?"密码长度不少于6位":null;
//              }
              },
            ),
            TextFormField(
              autofocus: false,
              obscureText: true,
              textInputAction: TextInputAction.next,
              controller: newPass,
              decoration: InputDecoration(
                  hintText: "输入新密码",
                  icon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff477BFF),
                  )),
              validator: (val){
                return newPass.text.length<6?"密码长度不少于6位":null;
//              }
              },
            ),
            TextFormField(
              autofocus: false,
              obscureText: true,
              textInputAction: TextInputAction.next,
              controller: surePass,
              decoration: InputDecoration(
                  hintText: "确认新密码",
                  icon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff477BFF),
                  )),
              validator: (val){
//                print(val);
//              if(newPass==null){
                return newPass.text.length==0?"请输入新密码":newPass.text==val?null:"请确认密码";
//              }
                return val;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(28.0)),
              child: Center(
                child: (
                  Container(
                    width: ScreenUtil().setWidth(452),
                    height: ScreenUtil().setHeight(90),
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
                            putNet("choosePass",formData: new FormData.from({
                              "password_old": oldPass.text,
                              "password_new": newPass.text,
                            })).then((res){
                              if(res["result"]==1){
                                Toast.show("修改成功");
                                Navigator.pop(context);
                              }
                            });
                          }
                        }),
                  )
                ),
              ),
            )
          ],
        ));
  }
}
