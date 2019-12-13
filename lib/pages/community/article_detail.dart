import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';
import '../../service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../public/threamDetail.dart';
import '../../public//play_video.dart';
import '../../public/photo_view.dart';
import '../../public/base.dart';

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
  var token;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getLoginInfo();
//    getThreamInfo();
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
        body: FutureBuilder(
          future: getNet('getThreamInfo', path: widget.id),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              threamDetail list = threamDetail.fromJson(snapshot.data);
              if (list.result == 1) {
//                setState(() {
                  threamInfo = list.data;
//                });
                print(threamInfo.id);
              }
              return threamContent();
            }else{
              return Text('正在加载');
            }
          },
        )
        );
  }

  //页面布局
  Widget threamContent(){
    return Column(
      children: <Widget>[
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
              SliverToBoxAdapter(
                child: threamTopModeule(),
              ),
              // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
              SliverFixedExtentList(
                  delegate: new SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      //创建列表项
                      return replyModeule(
                          threamInfo.threadReplyResp[index]);
                    },
                    childCount: threamInfo.threadReplyResp.length, //50个列表项
                  ),
                  itemExtent: ScreenUtil().setHeight(210))
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Color(0xffe5e5e5), width: 1.0))),
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
                  if (token == null) {
                    Toast.show("请先登录");
                  } else {
                    replyThream();
                  }
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
                        color: Colors.blue
//                                gradient: LinearGradient(
//                                    begin: Alignment.topLeft,
//                                    end: Alignment.bottomRight,
//                                    colors: [
//                                      Color(0xFF24B7E5),
//                                      Color(0xFF24B7E5)
//                                    ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
    if (_replyContent.text.toString().isEmpty) {
      Toast.show("请填写内容");
      return;
    } else {
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

  //判断是否登录
  _getLoginInfo() async {
    if (SpUtil.getSp() != null) {
      token = SpUtil.getSp().get('token');
    }
  }

  //点赞帖子
  void likeThrean() {
    postNet('likethreamOrReply', path: '${widget.id}/like').then((res) {
      if (res['result'] == 1) {
        getThreamInfo();
      }
    });
  }

  //点赞回复
  void likeReply(item) {
    postNet('likethreamOrReply', path: '${widget.id}/${item.id}/like')
        .then((res) {
      if (res['result'] == 1) {
        getThreamInfo();
      }
    });
  }

//  帖子
  Widget threamTopModeule() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(28.0)),
      child: Column(
        children: <Widget>[
          //标题
          Row(
            children: <Widget>[
              Text(
                threamInfo.title == null ? '标题' : threamInfo.title,
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
                  Container(
                    width: ScreenUtil().setWidth(64.0),
                    height: ScreenUtil().setWidth(64.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        image: DecorationImage(
                            image: threamInfo.userHeadImg == ''
                                ? AssetImage(
                                    'assets/image/hd.png',
                                  )
                                : NetworkImage(
                                    threamInfo.userHeadImg,
                                  ),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setSp(30.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          threamInfo.userName,
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
              InkWell(
                onTap: () {
                  if (token == null) {
                    Toast.show("请先登录");
                  } else {
                    likeThrean();
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Image.asset(
                          threamInfo.like == 1
                              ? 'assets/image/zan.png'
                              : 'assets/image/iszan.png',
                          width: 14,
                        )),
                    Text(
                      "${threamInfo.likeCount}",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(30.0),
                          color: Color(0xFF333333)),
                    ),
                  ],
                ),
              ),
            ],
          ),

//                帖子正文
          Container(
            alignment: Alignment(-1, -1),
            padding: EdgeInsets.only(
                top: ScreenUtil().setSp(25.0),
                bottom: ScreenUtil().setSp(15.0)),
            child: Text(threamInfo.describe),
          ),
//             帖子图片
          threamInfo.image.length == 0
              ? Container()
              : Container(
//                  height: ScreenUtil().setHeight(212.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: threamInfo.image.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.6),
                      itemBuilder: (BuildContext context, int index) {
                        return medioModeule(threamInfo.image[index]);
                      })),
          //    帖子标记，暂时不做
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setSp(15.0),
                bottom: ScreenUtil().setHeight(5.0)),
            child: Row(
              children: <Widget>[
                Text(
                  "帖子标记：${threamInfo.plate.toString() == null ? '无' : threamInfo.plate.toString() == '204' ? 'Abb' : '发那科'}",
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
                      Container(
                        width: ScreenUtil().setWidth(64.0),
                        height: ScreenUtil().setWidth(64.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                                image: item.userHeadImg == ''
                                    ? AssetImage(
                                        'assets/image/hd.png',
                                      )
                                    : NetworkImage(item.userHeadImg),
                                fit: BoxFit.cover)),
                      ),
                      //回复人昵称
                      Container(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
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
                      onTap: () {
                        if (token == null) {
                          Toast.show("请先登录");
                        } else {
                          likeReply(item);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Image.asset(
                                threamInfo.like == 1
                                    ? 'assets/image/zan.png'
                                    : 'assets/image/iszan.png',
                                width: 14,
                              )),
                          Text(
                            "${item.likeCount}",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(30.0),
                                color: Color(0xFF333333)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment(-1, -1),
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
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(84.0), top: 10.0, bottom: 10),
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
