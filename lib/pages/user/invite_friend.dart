import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';

class InviteFriendPage extends StatefulWidget {
  @override
  _InviteFriendPageState createState() {
    return new _InviteFriendPageState();
  }
}

class _InviteFriendPageState extends State<InviteFriendPage> {
  List formList = [];
  var token = null;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInviteNum();
  }

  Future getInviteNum() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.get('token');
//      print('token is ${token}');
      isLogin = token == null ? false : true;
      if (isLogin) {
        getNet('getInviteNum').then((res) {
//          print(res);
          if (res['result'] == 1) {
            setState(() {
              formList = res['data'].toList();
              print(formList);
            });
          }
        });
      }
    });
  }

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
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: new Text(
              "邀请有奖",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(41.0)),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '邀请好友下载APP',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(42.0),
                            color: Colors.white),
                      ),
                      Text(
                        '指南车APP诚邀你体验',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(42.0),
                            color: Colors.white,
                            height: 2.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(210.0)),
                    child: Column(
                      children: <Widget>[
//                        Text(
//                          '您的邀请码',
//                          style: TextStyle(
//                              fontSize: ScreenUtil().setSp(34.0),
//                              color: Colors.black,
//                              height: 3.5),
//                        ),
//                        Text(
//                          '12345678',
//                          style: TextStyle(
//                              fontSize: ScreenUtil().setSp(50.0),
//                              color: Color.fromRGBO(218, 76, 36, 1),
//                              letterSpacing: 18,
//                              height: 2.5),
//                        ),
//                        Text(
//                          '邀请的好友也可在注册时直接填写邀请码',
//                          style: TextStyle(
//                              fontSize: ScreenUtil().setSp(24.0),
//                              color: Colors.black,
//                              height: 3.0),
//                        ),
                        Text(
                          '点击下方按钮即可复制下载链接',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(34.0),
                              color: Colors.black,
                              height: 6.5),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setWidth(67.0)),
                          width: 200,
                          child: Material(
//                          color: Color.fromRGBO(49, 175, 255, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  gradient: LinearGradient(
                                    begin: Alignment(-1, 0),
                                    end: Alignment(1.0, 0),
                                    colors: <Color>[
                                      const Color(0xFFFF6F2E),
                                      const Color(0xFFFFA22E),
                                    ],
                                  ),
                                  boxShadow: [
                                    //阴影
                                    BoxShadow(
                                        color: Colors.grey[500],
                                        offset: Offset(0, 2.0),
                                        blurRadius: 2.0)
                                  ]),
                              child: MaterialButton(
                                  onPressed: copy,
                                  textColor: Colors.white,
                                  child: Text(
                                    "复制下载链接",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
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

copy() async {
  Clipboard.setData(ClipboardData(text: "12345678"));
}
