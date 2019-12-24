import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';

class NewsCenterPage extends StatefulWidget {
  @override
  _NewsCenterPageState createState() => _NewsCenterPageState();
}

class _NewsCenterPageState extends State<NewsCenterPage> {
  List _messageList = [];
  var token = null;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInteractive();
  }

  Future getInteractive() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.get('token');
//      print('token is ${token}');
      isLogin = token == null ? false : true;
      if (isLogin) {
        getNet('getInteractive').then((res) {
//          print(res);
          if (res['result'] == 1) {
            setState(() {
              _messageList = res['data'].toList();
              print(_messageList);
            });
          }
        });
      }
    });
  }

//  List _messageList =

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("互动消息"),
      ),
      body: ListView.builder(
          itemCount: _messageList.length,
          itemBuilder: (context, index) {
//            setState(() {
//              _messageList[index]['time'] = DateTime.fromMicrosecondsSinceEpoch(int.parse(_messageList[index]['time'])).toString().split(' ')[0].toString();
//              print(_messageList[index]['time']);
//            });
            return _messageView(index);
          }),
    );
  }

  Widget _messageView(int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, '/articleDetailPage?id=${_messageList[index]['main_id']}');
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(28.0)),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xFFE5E5E5)))),
        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//            Container(
//              margin: EdgeInsets.only(right: 10.0),
////              width: 50.0,
////              height: 50.0,
//              child: Image.asset("assets/image/info.png",width: 45.0,height: 45.0,),
//            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${_messageList[index]['action'] == 1 ? '点赞通知' : _messageList[index]['action'] == 2 ? '评论通知' : '点赞通知'}",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(32.0),
                    ),
                  ),
                  Divider(
                    height: ScreenUtil().setSp(7.0),
                    color: Colors.transparent,
                  ),
                  Text(
                    "${_messageList[index]['other_name']}${_messageList[index]['action'] == 1 ? '赞了你的帖子' : _messageList[index]['action'] == 2 ? '评论了你的帖子' : '赞了你的评论'}",
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: ScreenUtil().setSp(24.0),
                    ),
                  ),
//                  Text("测试",style: TextStyle(
//                      color: Color(0xFF999999),fontSize: 14.0
//                  ),)
                ],
              ),
            ),
            Container(
              child: Text(
                  DateTime.fromMillisecondsSinceEpoch(
                          _messageList[index]['date'])
                      .toString()
                      .split(' ')[0],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: ScreenUtil().setSp(22.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
