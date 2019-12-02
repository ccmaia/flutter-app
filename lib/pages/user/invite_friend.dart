import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class InviteFriendPage extends StatefulWidget {
  @override
  _InviteFriendPageState createState() {
    return new _InviteFriendPageState();
  }
}

class _InviteFriendPageState extends State<InviteFriendPage> {
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
//              style: TextStyle(
//                color: Colors.white,
//              ),
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
                        '很遗憾',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(46.0),
                            color: Colors.white),
                      ),
                      Text(
                        '您还没有邀请好友',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(46.0),
                            color: Colors.white,
                            height: 2.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(210.0)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '您的邀请码',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(34.0),
                              color: Colors.black,
                              height: 3.5),
                        ),
                        Text(
                          '12345678',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(50.0),
                              color: Color.fromRGBO(218, 76, 36, 1),
                              letterSpacing: 18,
                              height: 2.5),
                        ),
                        Text(
                          '邀请的好友也可在注册时直接填写邀请码',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(24.0),
                              color: Colors.black,
                              height: 3.0),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setWidth(47.0)),
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
                                    "复制邀请码",
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
