import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../public/base.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routers/application.dart'; //路由
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../service/service_method.dart';

class Community extends StatefulWidget {
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<Community> with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = new ScrollController();
  int _page = 1;
  List<Map> threadList = [
    {
      "id": "1",
      "title": "ABB机器人常见故障",
      "groups": "1",
      "tag": [],
      "image":
          "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
      "data": "",
      "like_count": "32",
      "replay_count": "25",
      "logo":
          "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
      "userName": "张三三"
    },
    {
      "id": "2",
      "title": "机器人第一次上电机报 警502，这是为什么？",
      "groups": "2",
      "tag": ["问答", "ABB"],
      "image":
          "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
      "data": "",
      "like_count": "32",
      "replay_count": "25",
      "logo":
          "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
      "userName": "张三三"
    },
    {
      "id": "3",
      "title": "ABB机器人常见故障",
      "groups": "1",
      "tag": [],
      "image":
          "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
      "data": "",
      "like_count": "32",
      "replay_count": "25",
      "logo":
          "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
      "userName": "张三三"
    },
    {
      "id": "3",
      "title": "ABB机器人常见故障如何解决处理干货 ",
      "groups": "2",
      "tag": ["兼职"],
      "image":
          "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
      "data": "",
      "like_count": "32",
      "replay_count": "25",
      "logo":
          "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
      "userName": "张三三"
    },
  ];

  @override
  bool get wantKeepAlive => true; //保持页面状态不刷新

  @override
  void initState() {
    super.initState();
    print('页面初始化------');
//
//    getBannerInfo();
    _scrollController.addListener(() {
//      print('____');
//      print(_scrollController.position.pixels);
//      print(_scrollController.position.maxScrollExtent);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('我监听到底部了!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ListView(
          children: <Widget>[
            searchWidgrt(),
            FutureBuilder(
              future: getBannerInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data['data']['list'];
                  List<Map> swiperDataList = (data as List).cast(); // 顶部轮播组件数
                  return Column(
                    children: <Widget>[
                      SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
                    ],
                  );
                } else {
                  return Container(
                      height: ScreenUtil().setHeight(245.0),
                      child: Center(
                        child: Text('loding'),
                      ));
                }
              },
            ),
            Container(
                height: ScreenUtil().setHeight(1000),
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 90.0),
                child: EasyRefresh(
                    onRefresh: _refreshData,
                    onLoad: _addMoreData,
                    child: StaggeredGridView.countBuilder(
                      itemCount: threadList.length,
                      primary: false,
                      crossAxisCount: 4,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      itemBuilder: (context, index) => Container(
                        child: threadWrap(threadList[index]),
                      ),
                      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                    ))),
          ],
        )

//        ListView(
//          children: <Widget>[
//           ,
//            FutureBuilder(
//              future: getBannerInfo(),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  var data = snapshot.data['data']['list'];
//                  List<Map> swiperDataList = (data as List).cast(); // 顶部轮播组件数
//                  return Column(
//                    children: <Widget>[
//                      SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
//                    ],
//                  );
//                } else {
//                  return Container(
//                      height: ScreenUtil().setHeight(245.0),
//                      child: Center(
//                        child: Text('loding'),
//                      ));
//                }
//              },
//            ),
//            Container(
//              height: ScreenUtil().setHeight(1000),
//                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 90.0),
//                child: EasyRefresh(
//                    onRefresh: _refreshData,
//                    onLoad: _addMoreData,
//                    child: StaggeredGridView.countBuilder(
////            controller: _scrollController,
//                      itemCount: threadList.length,
//                      primary: false,
//                      crossAxisCount: 4,
//                      mainAxisSpacing: 10.0,
//                      crossAxisSpacing: 10.0,
//                      itemBuilder: (context, index) => Container(
//                        child: threadWrap(threadList[index]),
//                      ),
//                      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
//                    ))),
//          ],
//        )
        );
  }

  getBannerInfo() {
//    getNet("getbannerList").then((res){
//      print(res);
//    });
  }

//  上拉刷新数据
  Future<Null> _refreshData() async {
    _page = 0;
    print("刷新");
  }

  //下拉加载更多
  Future<Null> _addMoreData() async {
    _page++;
    setState(() {
      threadList.addAll([
        {
          "id": "1",
          "title": "ABB机器人常见故障",
          "groups": "1",
          "tag": [],
          "image":
              "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
          "userName": "张三三"
        },
        {
          "id": "2",
          "title": "机器人第一次上电机报 警502，这是为什么？",
          "groups": "2",
          "tag": ["问答", "ABB"],
          "image":
              "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
          "userName": "张三三"
        },
        {
          "id": "3",
          "title": "ABB机器人常见故障",
          "groups": "1",
          "tag": [],
          "image":
              "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
          "userName": "张三三"
        },
        {
          "id": "3",
          "title": "ABB机器人常见故障如何解决处理干货 ",
          "groups": "2",
          "tag": ["兼职"],
          "image":
              "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
          "userName": "张三三"
        },
        {
          "id": "3",
          "title": "ABB机器人常见故障",
          "groups": "1",
          "tag": [],
          "image":
              "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
          "userName": "张三三"
        },
        {
          "id": "3",
          "title": "ABB机器人常见故障",
          "groups": "1",
          "tag": [],
          "image":
              "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=2389301591,2689380380&fm=85&s=F486BC1E45434D4D1476B07C0300407F",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
          "userName": "张三三"
        },
      ]);
    });
    print(_page);
  }

  void getCommunityList() {
    getNet("getthreadList").then((res) {
      print(res);
    });
  }

  RaisedButton _buildButton(String route, String url, String label) {
    return RaisedButton(
      onPressed: () {
        print(label);
        Application.router.navigateTo(
            context, '/eachPage?data=${Uri.encodeComponent(label)}');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Image.asset(
              url,
            ),
            width: ScreenUtil().setHeight(100),
            height: ScreenUtil().setHeight(100),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              label,
              style: TextStyle(color: Colors.black54),
            ),
          )
        ],
      ),
      color: Colors.transparent,
      elevation: 0.0,
      highlightElevation: 0.0,
    );
  }

  //顶部搜索widget
  Widget searchWidgrt() {
    return new Container(
      width: ScreenUtil().setWidth(720),
      padding: EdgeInsets.all(10.0),
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
        borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: Container(
                  decoration: new BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20.0)),
                    color: GlobalConfig.searchBackgroundColor,
                  ),
                  child: InkWell(
                    onTap: () {
                      print('search');
                      Application.router.navigateTo(context, '/searchPage');
                    },
                    child: Container(
                      height: 30.0,
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/image/search.png",
                            width: 22.0,
                            height: 20.0,
                          ),
                          Text(
                            '请输入您想搜索的内容',
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ))),
          new Container(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/image/notice.png',
                  width: 30.0, height: 30.0),
              color: Colors.black54,
            ),
            // height: 14.0,
            width: 40.0,
          ),
          new Container(
              width: 40.0,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset('assets/image/user.png',
                    width: 30.0, height: 30.0),
                color: Colors.black54,
              ))
        ],
      ),
    );
  }

  //帖子部分
  Widget threadWrap(item) {
    if (item["groups"] == "1") {
      return InkWell(
        onTap: () {},
        child: Container(
          width: ScreenUtil().setWidth(335),
//          margin: EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius:
                    BorderRadius.vertical(top: Radius.elliptical(10, 10)),
                child: Image.network(
                  item['image'],
                  fit: BoxFit.fill,
                  width: ScreenUtil().setWidth(335),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          item['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFF4C5772), fontSize: 16.0),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipOval(
                              child: Image.network(
                                item['logo'],
                                width: 28.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Text(
                                item['userName'],
                                style: TextStyle(
                                    color: Color(0xFFB3B3B3), fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "assets/image/zan.png",
                                width: 16,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Text(
                                item['like_count'],
                                style: TextStyle(
                                    color: Color(0xFF999999), fontSize: 14),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {},
        child: Container(
          width: ScreenUtil().setWidth(335),
//          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
                    color: Color(0xFF7DB2F3),
                    child: Text(
                      item['tag'][0],
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  )
                ],
              ),
              Container(
                child: Text(
                  item['title'],
                  style: TextStyle(
                    color: Color(0xFF4C5772),
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: Image.network(
                            item['logo'],
                            width: 28.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            item['userName'],
                            style: TextStyle(
                                color: Color(0xFFB3B3B3), fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border:
                              Border.all(color: Color(0xFFB9B9B9), width: 0.5)),
                      child: Text("去解答",
                          style: TextStyle(
                              color: Color(0xFFB9B9B9), fontSize: 12.0)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
        color: Colors.white,
      ),
      height: ScreenUtil().setHeight(245),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['banner_cover']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
