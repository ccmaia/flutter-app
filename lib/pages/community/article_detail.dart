import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  _ArticleDetailPageState createState() {
    return new _ArticleDetailPageState();
  }
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '帖子详情',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(ScreenUtil().setSp(28.0)),
            child: Column(
              children: <Widget>[
                //标题
                Text(
                  '机器人第一次上电开机报警50296, SMB内存数据差异”怎么办? ',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(34.0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                //浏览和回帖
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setSp(15.0),
                      bottom: ScreenUtil().setHeight(20.0)),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "123",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24.0),
                            color: Colors.grey[600]),
                      ),
                      Text(
                        "浏览  ·  ",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24.0),
                            color: Colors.grey[600]),
                      ),
                      Text(
                        "12",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24.0),
                            color: Colors.grey[600]),
                      ),
                      Text(
                        "回帖",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24.0),
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

//
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/image/hd.png',
//                      fit: BoxFit.none,
                      width: ScreenUtil().setWidth(64.0),
                      height: ScreenUtil().setHeight(64.0),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: ScreenUtil().setSp(30.0)),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "指南车",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(28.0),
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "楼主",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(28.0),
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
//                帖子正文
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setSp(25.0),
                      bottom: ScreenUtil().setSp(15.0)),
                  child: Text(
                      '机器人第一次上电开机报警50296,  SMB内存数据差异”怎么办? SMB内存数据差异”怎么办? SMB内存数据差异”怎么办?SMB内存数据差异”怎么办?'),
                ),
//             帖子图片
                Container(
                  height: ScreenUtil().setSp(200.0),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: ScreenUtil().setSp(15.0),
                        crossAxisSpacing: ScreenUtil().setSp(15.0),
                        childAspectRatio: 1),
                    children: <Widget>[
                      Image.asset(
                        'assets/image/threabg.png',
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(64.0),
                        height: ScreenUtil().setHeight(64.0),
                      ),
                      Image.asset(
                        'assets/image/threabg.png',
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(64.0),
                        height: ScreenUtil().setHeight(64.0),
                      ),
                      Image.asset(
                        'assets/image/threabg.png',
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(64.0),
                        height: ScreenUtil().setHeight(64.0),
                      ),
                    ],
                  ),
                ),
                //    帖子标记，暂时不做
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setSp(15.0),
                      bottom: ScreenUtil().setHeight(5.0)),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "帖子标记：",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24.0),
                            color: Colors.grey[600]),
                      ),
                      Text(
                        "PLC",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24.0),
                            color: Colors.grey[600]),
                      ),
                      Text(
                        "  机器人",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24.0),
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(750),
            height: 10.0,
            color: Color.fromRGBO(238, 238, 238, 1),
          ),
//          回复内容框
          ReplyView(),
          ReplyView(),
        ],
      ),
    );
  }
}

//回复内容框
class ReplyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ReplyViewState();
  }
}

class ReplyViewState extends State<ReplyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setSp(28.0),
        ScreenUtil().setSp(20.0),
        ScreenUtil().setSp(28.0),
        ScreenUtil().setSp(0.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  //回复人头像
                  Image.asset(
                    'assets/image/hd.png',
//                      fit: BoxFit.none,
                    width: ScreenUtil().setWidth(64.0),
                    height: ScreenUtil().setHeight(64.0),
                  ),
                  //                      回复人昵称
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setSp(20.0)),
                    child: Text(
                      "机器人",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28.0),
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setSp(20.0)),
                child: Row(
                  children: <Widget>[
                    //                      点赞
                    Icon(
                      Icons.thumb_up,
                      color: Colors.pinkAccent,
                      size: 18.0,
                    ),
                    Text(
                      "153",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28.0),
                          color: Colors.pinkAccent),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.only(left: ScreenUtil().setSp(84.0)),
              child: Text(
                  'SMB内存数据差异”怎么办? 机器人第一次上电开机报警50296,  SMB内存数据差异”怎么办? SMB内存数据差异”怎么办? SMB内存数据差异”怎么办?SMB内存数据差异”怎么办?')),
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setSp(15.0), left: ScreenUtil().setSp(84.0)),
            height: ScreenUtil().setSp(200.0),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: ScreenUtil().setSp(15.0),
                  crossAxisSpacing: ScreenUtil().setSp(15.0),
                  childAspectRatio: 1),
              children: <Widget>[
                Image.asset(
                  'assets/image/3.jpg',
                  fit: BoxFit.cover,
                  width: ScreenUtil().setWidth(64.0),
                  height: ScreenUtil().setHeight(64.0),
                ),
                Image.asset(
                  'assets/image/3.jpg',
                  fit: BoxFit.cover,
                  width: ScreenUtil().setWidth(64.0),
                  height: ScreenUtil().setHeight(64.0),
                ),
                Image.asset(
                  'assets/image/3.jpg',
                  fit: BoxFit.cover,
                  width: ScreenUtil().setWidth(64.0),
                  height: ScreenUtil().setHeight(64.0),
                ),
                Image.asset(
                  'assets/image/3.jpg',
                  fit: BoxFit.cover,
                  width: ScreenUtil().setWidth(64.0),
                  height: ScreenUtil().setHeight(64.0),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment(-1.0, -1.0),
            padding: EdgeInsets.only(
                left: ScreenUtil().setSp(84.0),
                top: ScreenUtil().setSp((10.0)),
                bottom: ScreenUtil().setWidth(25.0)),
            child: Text(
              '3小时前',
              textAlign: TextAlign.left,
              style: TextStyle(
                  inherit: false,
                  fontSize: ScreenUtil().setSp(24.0),
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
