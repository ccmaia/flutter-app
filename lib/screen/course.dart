import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/course/course_msg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../routers/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/service_method.dart';

class Course extends StatefulWidget {
  _Course createState() => _Course();
}

class _Course extends State<Course> {
  List _messageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return SafeArea(
      child: DefaultTabController(
        length: 3, //项的数量
        initialIndex: 0, //默认选择第一项
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(15.0)),
              color: Colors.white,
              child: AspectRatio(
                aspectRatio: 8.0,
                child: TabBar(
//                    isScrollable: true,//项少的话，无需滚动（自动均分屏幕宽度），多的话，设为true
                  indicatorColor: Colors.blue,
                  indicatorWeight: 2,
                  unselectedLabelColor: Colors.black87,
                  labelColor: Colors.blue,
                  tabs: [
                    Tab(
                      text: "在线课程",
                    ),
                    Tab(
                      text: "技术文档",
                    ),
                    Tab(
                      text: "作业指导",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder(
                    future: getNet('getCourse'),
                    builder: (context, data){
                      if(data.hasData){
                        _messageList = data.data['data'];
                        return ListView.builder(
                            itemCount: _messageList.length,
                            itemBuilder: (context, index) {
                              return _messageView(index);
                            });
                      }else{
                        return Text("数据加载");
                      }
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Text('这是技术文档页面'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('这是作业指导页面'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _messageView(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return new CourseMsg();
        }));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(top: BorderSide(width: 1, color: Color(0xFFE5E5E5)))),
        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(240.0),
              height: ScreenUtil().setWidth(180.0),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/image/invite-bg.png",
                      ),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(32.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${_messageList[index]['name']}",
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: ScreenUtil().setSp(28.0),
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                      child: Text(
                        "${_messageList[index]['describe']}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenUtil().setSp(26.0),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                          child: Row(
                            children: <Widget>[
                              Row(
                                verticalDirection: VerticalDirection.up,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/image/userpage.png",
                                    width: ScreenUtil().setWidth(25.0),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setHeight(8)),
                                    child: Text(
                                      "${_messageList[index]['author']}",
                                      style: TextStyle(
                                          color: Color(0xFF5C6784),
                                          fontSize: ScreenUtil().setSp(25.0)),
                                    ),
//                        margin: EdgeInsets.only(top: 5),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setHeight(20)),
                                child: Row(
                                  verticalDirection: VerticalDirection.up,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/image/time.png",
                                      width: ScreenUtil().setWidth(25.0),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setHeight(9)),
                                      child: Text(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                _messageList[index]['date'])
                                            .toString()
                                            .split(' ')[0],
                                        style: TextStyle(
                                            color: Color(0xFF5C6784),
                                            fontSize: ScreenUtil().setSp(25.0)),
                                      ),
//                        margin: EdgeInsets.only(top: 5),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
//                    Text(
//                      "${_messageList[index]['userName']}${_messageList[index]['behavior'] == 1 ? '赞了你的评论' : _messageList[index]['behavior'] == 2 ? '评论了你的帖子' : '赞了你的帖子'}",
//                      style: TextStyle(color: Color(0xFF999999), fontSize: 14.0),
//                    ),
//                    Text('${_messageList[index]['time']}',
//                        style:
//                            TextStyle(color: Color(0xFF999999), fontSize: 14.0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
