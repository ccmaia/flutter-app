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
  List formList=[];
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
//              userInfo = res['data'];
              formList = res['data'].toList();
              print(formList);
//              print(userInfo);
            });
          }
        });
      }
    });
  }

  List _messageList = [
    {
      "title": "帖子互动",
      "id": 1,
      "userId": 1222,
      "userName": "张三三",
      "behavior": 1, //  1赞了评论 2评论 3赞了帖子
      "time": "1575016237713"
    },
    {
      "title": "帖子互动",
      "id": 1,
      "userId": 1222,
      "userName": "张四四",
      "behavior": 2, //  1赞 2评论
      "time": "1575016237713"
    },
    {
      "title": "帖子互动",
      "id": 1,
      "userId": 1222,
      "userName": "张五五",
      "behavior": 3, //  1赞了评论 2评论 3赞了帖子
      "time": "1575016237713"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("消息中心"),
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
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0,10.0,20.0,10.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xFFE5E5E5)))),
        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0),
//              width: 50.0,
//              height: 50.0,
              child: Image.asset("assets/image/info.png",width: 45.0,height: 45.0,),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('帖子互动',style: TextStyle(
                      color: Color(0xFF333333),fontSize: 16.0,fontWeight:FontWeight.w500
                  ),),
                  Text("${_messageList[index]['userName']}${_messageList[index]['behavior']==1?'赞了你的评论':_messageList[index]['behavior']==2?'评论了你的帖子':'赞了你的帖子'}",style: TextStyle(
                      color: Color(0xFF999999),fontSize: 14.0
                  ),)
                ],
              ),
            ),
            Container(
              child: Text('${_messageList[index]['time']}',style: TextStyle(
                  color: Color(0xFF999999),fontSize: 14.0
              )),
            )
          ],
        ),
      ),
    );
  }
}
