import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';
import '../../service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../public/threamDetail.dart';
import '../../public//play_video.dart';
import '../../public/photo_view.dart';

class ArticleDetailPage extends StatefulWidget {
  String id;

  ArticleDetailPage(this.id);

  @override
  _ArticleDetailPageState createState() {
    return new _ArticleDetailPageState();
  }
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  Data threamInfo;
  TextEditingController _replyContent = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    getThreamInfo();
    super.initState();
    print('id is ${widget.id}');
  }

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
        body: threamInfo.title == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SpinKitCircle(
                      color: Colors.blueAccent,
                      size: 30.0,
                    ),
                    Text('正在加载')
                  ],
                ),
              )
            : Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  threamTopModeule(),
                  Container(
                    height: 300,
                    child: ListView.builder(
                        itemCount: threamInfo.threadReplyResp.length,
                        itemBuilder: (BuildContext context, int index) {
                          return replyModeule(
                              threamInfo.threadReplyResp[index]);
                        }),
                  )
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                            color: Color(0xffe5e5e5), width: 1.0))),
                padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setSp(20.0),
                  ScreenUtil().setSp(15.0),
                  ScreenUtil().setSp(0.0),
                  ScreenUtil().setSp(15.0),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: (TextField(
                        controller: _replyContent,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none),
                          fillColor: Colors.grey[150],
                          filled: true,
                          contentPadding:
                          EdgeInsets.all(ScreenUtil().setSp(12.0)),
                          hintText: '写评论...',
                        ),
                      )),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        replyThream();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setSp(15.0),
                            right: ScreenUtil().setSp((18.0))),
                        child: Container(
                          child: Text(
                            '发送',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(32.0)),
                          ),
                          padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(28.0),
                            ScreenUtil().setHeight(15.0),
                            ScreenUtil().setHeight(28.0),
                            ScreenUtil().setHeight(15.0),
                          ),
                          // height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
//                          bottomLeft: Radius.circular(25.0),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF24B7E5),
                                  Color(0xFF24B7E5)
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

          ],
        )


//        Stack(
//          children: <Widget>[
//            //帖子正文
//            Column(
//              children: <Widget>[
//                threamTopModeule(),
//                Container(
//                  height: 10.0,
//                  color: Color.fromRGBO(238, 238, 238, 1),
//                ),
//                Expanded(
//                  child: Container(
////                    padding: EdgeInsets.only(bottom: 80),
//                    child: ListView.builder(
//                        itemCount: threamInfo.threadReplyResp.length,
//                        itemBuilder: (BuildContext context, int index) {
//                          return replyModeule(
//                              threamInfo.threadReplyResp[index]);
//                        }),
//                  )
//                )
//              ],
//            ),
//
//            Positioned(
//              bottom: 0,
//              left: 0,
//              right: 0,
//              child: Container(
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    border: Border(
//                        top: BorderSide(
//                            color: Color(0xffe5e5e5), width: 1.0))),
//                padding: EdgeInsets.fromLTRB(
//                  ScreenUtil().setSp(20.0),
//                  ScreenUtil().setSp(15.0),
//                  ScreenUtil().setSp(0.0),
//                  ScreenUtil().setSp(15.0),
//                ),
//                child: Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: (TextField(
//                        controller: _replyContent,
//                        decoration: InputDecoration(
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(100),
//                              borderSide: BorderSide.none),
//                          fillColor: Colors.grey[150],
//                          filled: true,
//                          contentPadding:
//                          EdgeInsets.all(ScreenUtil().setSp(12.0)),
//                          hintText: '写评论...',
//                        ),
//                      )),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        FocusScope.of(context).requestFocus(FocusNode());
//                        replyThream();
//                      },
//                      child: Padding(
//                        padding: EdgeInsets.only(
//                            left: ScreenUtil().setSp(15.0),
//                            right: ScreenUtil().setSp((18.0))),
//                        child: Container(
//                          child: Text(
//                            '发送',
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontSize: ScreenUtil().setSp(32.0)),
//                          ),
//                          padding: EdgeInsets.fromLTRB(
//                            ScreenUtil().setWidth(28.0),
//                            ScreenUtil().setHeight(15.0),
//                            ScreenUtil().setHeight(28.0),
//                            ScreenUtil().setHeight(15.0),
//                          ),
//                          // height: 50.0,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(
//                              Radius.circular(25.0),
////                          bottomLeft: Radius.circular(25.0),
//                            ),
//                            gradient: LinearGradient(
//                                begin: Alignment.topLeft,
//                                end: Alignment.bottomRight,
//                                colors: [
//                                  Color(0xFF24B7E5),
//                                  Color(0xFF24B7E5)
//                                ]),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            )
//          ],
//        )
        );
  }

  //  获取帖子详情
  void getThreamInfo() {
    getNet('getThreamInfo', path: widget.id).then((res) {
      print(res);
      threamDetail list = threamDetail.fromJson(res);
      if (list.result == 1) {
        setState(() {
          threamInfo = list.data;
        });
        print(threamInfo.id);
      }
    });
  }

  //评论帖子
  void replyThream() {
    if(_replyContent.text.toString().isEmpty){
      Toast.show("请填写内容");
      return;
    }else{
      FormData formData = new FormData.from({"describe": _replyContent.text});
      print(formData);
      postNet('replyThream', path: '${widget.id}/reply', formData: formData)
          .then((res) {
        if (res['result'] == 1) {
          Toast.show('评论成功');
          _replyContent.text = '';
          getThreamInfo();
        }
      });
    }
  }

  //点赞帖子
  void likeThrean(){
    postNet('likethreamOrReply',path: '${widget.id}/like').then((res){
      if(res['result']==1){
        Toast.show("点赞成功");
      }
    });
  }

  //点赞回复

//  帖子
  Widget threamTopModeule(){
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(28.0)),
      child: Column(
        children: <Widget>[
          //标题
          Row(
            children: <Widget>[
              Text(
                threamInfo.title == null
                    ? '标题'
                    : threamInfo.title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(34.0),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          //浏览和回帖
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setSp(15.0),
                bottom: ScreenUtil().setHeight(20.0)),
            child: Row(
              children: <Widget>[
//                            Text(
//                              "123浏览  ·  ",
//                              style: TextStyle(
//                                  fontSize: ScreenUtil().setSp(24.0),
//                                  color: Colors.grey[600]),
//                            ),
                Text(
                  "${threamInfo.replyCount}回帖  ·  ",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24.0),
                      color: Colors.grey[600]),
                ),
                Text(
                  "${threamInfo.likeCount}点赞",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24.0),
                      color: Colors.grey[600]),
                )
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  threamInfo.userHeadImg == ''
                      ? Image.asset(
                    'assets/image/hd.png',
                    width: ScreenUtil().setWidth(64.0),
                    height: ScreenUtil().setWidth(64.0),
                  )
                      : Image.network(
                    threamInfo.userHeadImg,
                    width: ScreenUtil().setWidth(64.0),
                    height: ScreenUtil().setWidth(64.0),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setSp(30.0)),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          threamInfo.userName,
                          style: TextStyle(
                              fontSize:
                              ScreenUtil().setSp(28.0),
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "楼主",
                          style: TextStyle(
                              fontSize:
                              ScreenUtil().setSp(28.0),
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  print('点赞');
                  likeThrean();
                },
                child: Row(
                  children: <Widget>[
                    //                      点赞
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 20.0,
                    ),
                    Text(
                      "${threamInfo.likeCount}",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(30.0),
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),

//                帖子正文
          Container(
            alignment: Alignment(-1,-1),
            padding: EdgeInsets.only(
                top: ScreenUtil().setSp(25.0),
                bottom: ScreenUtil().setSp(15.0)),
            child: Text(threamInfo.describe),
          ),
//             帖子图片
          threamInfo.image.length==0?Container():Container(
              height: ScreenUtil().setHeight(212.0),
              child: GridView.builder(
                  itemCount: threamInfo.image.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.6),
                  itemBuilder:
                      (BuildContext context, int index) {
                    return medioModeule(
                        threamInfo.image[index]);
                  })),
          //    帖子标记，暂时不做
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setSp(15.0),
                bottom: ScreenUtil().setHeight(5.0)),
            child: Row(
              children: <Widget>[
                Text(
                  "帖子标记：${threamInfo.plate.toString()==null?'无': threamInfo.plate.toString() == '204' ? 'Abb' : '发那科'}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24.0),
                      color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//  公用medio模块
  Widget medioModeule(item) {
    if (item.toString().contains('mp4')) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            image: DecorationImage(
                image: NetworkImage(
                    "${item}?x-oss-process=video/snapshot,t_7000,f_jpg,w_800,h_600,m_fast"),
                fit: BoxFit.fill)),
        child: Center(
            child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return VideoAutoPlayWhenReady(item);
            }));
          },
          child: Icon(
            Icons.play_circle_outline,
            color: Colors.grey,
            size: 35,
          ),
        )),
      );
    } else {
      return Stack(
        children: <Widget>[
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  image: DecorationImage(
                      image: NetworkImage(item), fit: BoxFit.fill)),
            ),
            onTap: () {
              List imgList = [];
              threamInfo.image.forEach((item) {
                if (item.toString().contains("jpg")) {
                  imgList.add(item);
                }
              });
              final i = imgList.indexOf(item);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new PhotoViewGalleryScreen(
                            images: imgList,
                            index: i,
                            heroTag: item,
                          )));
            },
          ),
        ],
      );
    }
  }

//回复列表
  Widget replyModeule(item) {
    return Column(
      children: <Widget>[
        Container(
          height: 5.0,
          color: Color.fromRGBO(238, 238, 238, 1),
        ),
    Container(
//      decoration: BoxDecoration(
//          border:
//              Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
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
                  item.userHeadImg == ''
                      ? Image.asset(
                    'assets/image/hd.png',
                    width: ScreenUtil().setWidth(64.0),
                    height: ScreenUtil().setWidth(64.0),
                  )
                      : Image.network(
                    threamInfo.userHeadImg,
                    width: ScreenUtil().setWidth(64.0),
                    height: ScreenUtil().setWidth(64.0),
                  ),
                  //                      回复人昵称
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
                    child: Text(
                      "${item.userName}",
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
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        color: Colors.pinkAccent,
                        size: 20.0,
                      ),
                      Text(
                        "${item.likeCount}",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(30.0),
                            color: Colors.pinkAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
              alignment: Alignment(-1,-1),
              padding: EdgeInsets.only(left: ScreenUtil().setSp(84.0)),
              child: Text('${item.describe}')),
//          Container(
//            padding: EdgeInsets.only(
//                top: ScreenUtil().setSp(15.0), left: ScreenUtil().setSp(84.0)),
//            height: ScreenUtil().setSp(200.0),
//            child: GridView(
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 3,
//                  mainAxisSpacing: ScreenUtil().setSp(15.0),
//                  crossAxisSpacing: ScreenUtil().setSp(15.0),
//                  childAspectRatio: 1),
//              children: <Widget>[
//                Image.asset(
//                  'assets/image/3.jpg',
//                  fit: BoxFit.cover,
//                  width: ScreenUtil().setWidth(64.0),
//                  height: ScreenUtil().setHeight(64.0),
//
//                ),
//                Image.asset(
//                  'assets/image/3.jpg',
//                  fit: BoxFit.cover,
//                  width: ScreenUtil().setWidth(64.0),
//                  height: ScreenUtil().setHeight(64.0),
//                ),
//                Image.asset(
//                  'assets/image/3.jpg',
//                  fit: BoxFit.cover,
//                  width: ScreenUtil().setWidth(64.0),
//                  height: ScreenUtil().setHeight(64.0),
//                ),
//                Image.asset(
//                  'assets/image/3.jpg',
//                  fit: BoxFit.cover,
//                  width: ScreenUtil().setWidth(64.0),
//                  height: ScreenUtil().setHeight(64.0),
//                ),
//              ],
//            ),
//          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(left:ScreenUtil().setWidth(84.0),top:10.0,bottom: 10),
            child: Text(
              '${DateTime.fromMillisecondsSinceEpoch(item.date).toString().split(' ')[0]}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  inherit: false,
                  fontSize: ScreenUtil().setSp(24.0),
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    )
      ],
    );


  }
}

