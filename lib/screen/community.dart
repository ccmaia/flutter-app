import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';
import 'package:flutter_app_test/public/threaData.dart';
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
import '../public/plateData.dart';
import '../public/threaData.dart';

class Community extends StatefulWidget {
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<Community> with AutomaticKeepAliveClientMixin {
  ScrollController _controller = new ScrollController();

  int _page = 1;
  List threadList = [];
  List plateList = [];

  @override
  bool get wantKeepAlive => true; //保持页面状态不刷新

  @override
  void initState() {
    super.initState();
    print('页面初始化------');

    setState(() {
      getNet("getThreadPlate").then((res) {
        print(res['data']);
        plateData list = plateData.formJson(res['data']);
        plateList = list.data;
        getThreams();
      });
    });
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
                child: _page > 1
                    ? null
                    : FutureBuilder(
                        future: getNet("getbannerList"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data['data'];
                            List<Map> swiperDataList =
                                (data as List).cast(); // 顶部轮播组件数
                            return Column(
                              children: <Widget>[
                                SwiperDiy(
                                    swiperDataList: swiperDataList), //页面顶部轮播组件
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
                child: Container(
                    padding: EdgeInsets.all(10.0),
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
                          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                        ))),
              )
            ],
          ),
        ));
  }

//  上拉刷新数据
  Future<Null> _refreshData() async {
    _page = 1;
//    getThream();
    getThreams();
  }

  //下拉加载更多
  Future<Null> _addMoreData() async {
    _page++;
    getThreams();
  }

//  获取帖子列表
  void getThreams() {
    var data = {'_b': (_page - 1) * 10 + 1, '_e': _page * 10};
    getNet("getthreadList", data: data).then((res) {
      if (res['result'] == 1) {
        setState(() {
          if (_page == 1) {
            threamData list = threamData.formJson(res['data']);
            threadList = list.data;
          } else {
            threamData list = threamData.formJson(res['data']);
            if (list.data.length == 0) {
              Toast.show('没有更多了');
            } else {
              threadList.addAll(list.data);
            }
          }
          threadList.forEach((item) {
            plateList.forEach((type) {
              if (type.id == item.plate) {
                item.plateName = type.name;
              }
            });
          });
        });
      }
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
                'assets/image/user.png',
                width: 24,
              ),
            ))
      ],
    );
  }

  //帖子部分
  Widget threadWrap(item) {
    if (item.groups.toString() != null) {
      if (item.groups == 1) {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, '/articleDetailPage?id=${item.id}');
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
                  child: item.image.length == 0
                      ? Image.asset(
                          'assets/image/threabg.png',
                          fit: BoxFit.cover,
                          width: ScreenUtil().setWidth(335),
                        )
                      : Image.network(
                          item.image[0],
                          fit: BoxFit.cover,
                          width: ScreenUtil().setWidth(335),
                          height: ScreenUtil().setHeight(210),
                        ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            item.title,
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
                                child: item.userHeadImg == ''
                                    ? Image.asset(
                                        'assets/image/not_login.png',
                                        width: 28.0,
                                      )
                                    : Image.network(
                                        item.userHeadImg,
                                        width: 28.0,
                                      ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  item.userName,
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
                                  item.likeCount.toString(),
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
            Application.router.navigateTo(context, '/articleDetailPage?id=${item.id}');
          },
          child: Container(
            width: ScreenUtil().setWidth(335),
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
                      padding: EdgeInsets.fromLTRB(3.0, 1.0, 3.0, 1.0),
                      color: Color(0xFF7DB2F3),
                      child: Text(
                        '问答',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0),
                      padding: EdgeInsets.fromLTRB(3.0, 1.0, 3.0, 1.0),
                      color: Color(0xFF3AAC4F),
                      child: Text(
                        item.plateName,
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
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
                            child: item.userHeadImg == ''
                                ? Image.asset(
                                    'assets/image/not_login.png',
                                    width: 28.0,
                                  )
                                : Image.network(
                                    item.userHeadImg,
                                    width: 28.0,
                                  ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              item.userName,
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
                            border: Border.all(
                                color: Color(0xFFB9B9B9), width: 0.5)),
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
          return Image.network("${swiperDataList[index]['img']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
