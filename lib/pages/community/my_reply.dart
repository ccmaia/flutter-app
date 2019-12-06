import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

class MyReplyPage extends StatefulWidget {
  @override
  _MyReplyPageState createState() => _MyReplyPageState();
}

class _MyReplyPageState extends State<MyReplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的回帖',
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body:
      Container(
        color: Color.fromRGBO(240, 240, 240, 1),
        child: ListView(
          children: <Widget>[
            Container(
                child: Container(
                  child: Column(
                    children: <Widget>[
//            这是单个消息通知
                      InkWell(
                        onTap: () {
                          Application.router
                              .navigateTo(context, '/articleDetailPage');
                        },
                        child: Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(30.0)),
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                        child: Text(
                                          '这里是回复的内容',
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(40.0)),
                                        ),
                                      )),
                                ],
                              ),
                              Divider(
                                height: ScreenUtil().setSp(5.0),
                                color: Colors.transparent,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      '2019.12.12 19:30',
                                      style: TextStyle(
                                          color: Color(0xFF5C6784),
                                          fontSize: ScreenUtil().setSp(24.0)),
                                    ),
//                                  margin: EdgeInsets.only(
//                                      left: ScreenUtil().setWidth(15.0)),
                                  ),
                                  Text(
                                    "  ·  ",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(24.0),
                                    ),
                                  ),
                                  Text(
                                    "15",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(24.0),
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    "个赞  ·  来自",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(24.0),
                                    ),
                                  ),
                                  Text(
                                    "这里是帖子的标题",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(24.0),
                                      color: Colors.lightBlue,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
