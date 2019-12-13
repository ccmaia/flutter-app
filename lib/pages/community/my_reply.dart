import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';

class MyReplyPage extends StatefulWidget {
  @override
  _MyReplyPageState createState() => _MyReplyPageState();
}

class _MyReplyPageState extends State<MyReplyPage> {
  List formList = [];
  var token = null;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyReply();
  }

  Future getMyReply() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.get('token');
      print('token is ${token}');
      isLogin = token == null ? false : true;
      if (isLogin) {
        getNet('getMyReply').then((res) {
//          print(res);
          if (res['result'] == 1) {
            setState(() {
//              userInfo = res['data'];
              formList = res['data'];
              print(formList);
//              print(userInfo);
            });
          }
        });
      }
    });
  }

  Widget buildGrid() {
    List<Widget> tiles = [];
    for (var item in formList) {
      tiles.add(
        InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/articleDetailPage');
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFE5E5E5))),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(ScreenUtil().setWidth(30.0)),
//            color: Colors.white,

            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: Text(
                        item['describe'],
                        style: TextStyle(fontSize: ScreenUtil().setSp(32.0)),
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
                        DateTime.fromMillisecondsSinceEpoch(item['date'])
                            .toString(),
                        style: TextStyle(
                            color: Color(0xFF5C6784),
                            fontSize: ScreenUtil().setSp(24.0)),
                      ),
//
                    ),
                    Text(
                      "  ·  ",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(24.0),
                      ),
                    ),
                    Text(
//                      '12',
                      '${item['like_count']}',
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
                      item['thread_title'].toString(),
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
      );
    }
    return Column(children: tiles);
  }

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
      body: Container(
        color: Color.fromRGBO(240, 240, 240, 1),
        child: ListView(
          children: <Widget>[
            buildGrid(),
          ],
        ),
      ),
    );
  }
}
