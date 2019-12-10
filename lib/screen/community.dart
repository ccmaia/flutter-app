import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import '../public/base.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routers/application.dart'; //路由
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../service/service_method.dart';

class Community extends StatefulWidget {
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<Community> with AutomaticKeepAliveClientMixin {
  ScrollController _controller = new ScrollController();

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
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
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
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
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
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
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
    getCommunityList();
    _controller.addListener(() {
      print(_controller.offset);
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
        floatingActionButton: InkWell(
          child: Image.asset("assets/image/add.png",
              width: ScreenUtil().setWidth(120)),
          onTap: () {
            Application.router.navigateTo(context, "/choosethreadTypePage");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          title: searchWidgrt(),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 1.0,
        ),
        body: Scrollbar(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: _page>1?Text(""):FutureBuilder(
                  future: getBannerInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data['data']['list'];
                      List<Map> swiperDataList =
                      (data as List).cast(); // 顶部轮播组件数
                      return Column(
                        children: <Widget>[
                          SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
                        ],
                      );
                    } else {
                      return Container(
                          height: ScreenUtil().setHeight(245.0),
                          child: Center(
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
                          ));
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child:
                Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      child: EasyRefresh(
                          header: BallPulseHeader(),
                          footer: BallPulseFooter(),
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
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(2),
                          ))),
              )
            ],
          ),
        ));
  }

  getBannerInfo() {
//    getNet("getbannerList").then((res){
////      print('banner is ${res}');
//    });
  }

//  上拉刷新数据
  Future<Null> _refreshData() async {
    getCommunityList();
    _page = 1;
    setState(() {
      threadList = [
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
              "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
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
              "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
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
              "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webp",
          "userName": "张三三"
        },
      ];
    });
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
              "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
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
              "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg",
          "data": "",
          "like_count": "32",
          "replay_count": "25",
          "logo":
              "https://upload.jianshu.io/users/upload_avatars/995581/b6541e1a-d5ac-4d54-aa77-a0c8a575431a.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/80/h/80/format/webpg",
          "userName": "张三三"
        },
        {
          "id": "3",
          "title": "ABB机器人常见故障",
          "groups": "1",
          "tag": [],
          "image":
              "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2752453349,2871240348&fm=26&gp=0.jpg",
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
              "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2752453349,2871240348&fm=26&gp=0.jpg",
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
              "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2752453349,2871240348&fm=26&gp=0.jpg",
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
              "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2752453349,2871240348&fm=26&gp=0.jpg",
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


//  Future getCommunityList() async{
//    try{
//      Response response;
//      var data={'_b':1,'_e':10};
//      response = await Dio().get(
//          "https://test.zhinanche.com/api/v2/zhinanche-app/thread",
//          queryParameters:data
//      );
//      print(response.data);
//      return response.data;
//    }catch(e){
//      return print(e);
//    }
//  }
  void getCommunityList() {
    var data={'_b':1,'_e':10};
    getNet("getthreadList",data: {data}).then((res) {
      print("帖子${res}");
    });
  }

  //顶部搜索widget
  Widget searchWidgrt() {
    return Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            //修饰黑色背景与圆角
            decoration: new BoxDecoration(
//          border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
              color: Color(0xFFEEEEEE),
              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
            ),
            alignment: Alignment.center,
            height: 36,
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: Container(
                decoration: new BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(5.0)),
                  color: GlobalConfig.searchBackgroundColor,
                ),
                child: InkWell(
                  onTap: () {
                    print('search');
                    Application.router.navigateTo(context, '/searchPage');
                  },
                  child: Container(
                    height: 36.0,
                    padding: EdgeInsets.only(left: 5.0),
//                    padding: EdgeInsets.only(left: 5.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/image/search.png",
                          width: 22.0,
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '请输入您想搜索的内容',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 20.0),
            child: InkWell(
              onTap: () {
                Application.router.navigateTo(context, '/personalCenterPage');
              },
              child: Image.asset(
                'assets/image/user.png',width: 24,
              ),
            ))
      ],
    );
  }

  //帖子部分
  Widget threadWrap(item) {
    if (item["groups"] == "1") {
      return InkWell(
        onTap: () {
          Application.router.navigateTo(context, '/articleDetailPage');
        },
        child: Container(
          width: ScreenUtil().setWidth(335),
//          margin: EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
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
        onTap: () {
          Application.router.navigateTo(context, '/articleDetailPage');
        },
        child: Container(
          width: ScreenUtil().setWidth(335),
//          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
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

//轮播tu
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
