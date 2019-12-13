import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
class MyArticlePage extends StatefulWidget {
  @override
  _MyArticlePageState createState() => _MyArticlePageState();
}

class _MyArticlePageState extends State<MyArticlePage> {
  List formList=[];
  var token = null;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyThread();
  }

  Future getMyThread() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.get('token');
//      print('token is ${token}');
      isLogin = token == null ? false : true;
      if (isLogin) {
        getNet('getMyThread').then((res) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '我的发帖',
            style: TextStyle(),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount:formList.length,
          itemBuilder: (context,index){
            return ListItem(data:formList[index]);
          },
        )
    );
  }
}


class ListItem extends StatelessWidget {
  final Map data;
  const ListItem({Key key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/articleDetailPage');
      },
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setWidth(30.0),),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: Color(0xFFE5E5E5))),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      child: Text(
                        data['title'],
                        style: TextStyle(fontSize: ScreenUtil().setSp(32.0),),
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
                Expanded(
                    child: Container(
                      child: Text(
//                              '12',
                        DateTime.fromMillisecondsSinceEpoch(data['date'])
                          .toString(),
//                              item['date'],
                        style: TextStyle(
                          color: Color(0xFF5C6784),
                          fontSize: ScreenUtil().setSp(24.0),),
                      ),
//                                  margin: EdgeInsets.only(
//                                      left: ScreenUtil().setWidth(15.0)),
                    )),
                Text(
//                      "12回复",
                  '${data['reply_count']}回复',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24.0),
                    color: Colors.grey[600],),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}