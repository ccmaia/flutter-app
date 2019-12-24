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
import '../public/base.dart';

class Community extends StatefulWidget {
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<Community> with AutomaticKeepAliveClientMixin {
  int _page = 1;
  List threadList = [];
  List plateList = [];
  List brandList = [];
  var token;

  @override
  bool get wantKeepAlive => true; //保持页面状态不刷新

  @override
  void initState() {
    super.initState();
    print('页面初始化------');
    setState(() {
      //获取帖子板块
      getNet("getThreadPlate").then((res) {
        print(res['data']);
        plateData list = plateData.formJson(res['data']);
        plateList = list.data;
        getThreams();
      });

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getLoginInfo();
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
        floatingActionButton: InkWell(
          child: Image.asset("assets/image/add.png",
              width: ScreenUtil().setWidth(100)),
          onTap: () {
            if (token == null) {
              Toast.show("请先登录");
            } else {
              Application.router.navigateTo(context, "/choosethreadTypePage");
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: PreferredSize(
          child: searchWidgrt(),
//          AppBar(
//            title: searchWidgrt(),
//            backgroundColor: Colors.white,
//            automaticallyImplyLeading: false,
//            elevation: 0,
//          ),
          preferredSize: Size.fromHeight(52),
        ),
        body: Container(
          color: Colors.white,
          child: Scrollbar(
              child: EasyRefresh(
                  header: BallPulseHeader(),
                  footer: BallPulseFooter(),
                  onRefresh: _refreshData,
                  onLoad: _addMoreData,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                          child: Column(
                        children: <Widget>[
                          FutureBuilder(
                            future: getNet("getbannerList"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data['data'];
                                List<Map> swiperDataList =
                                    (data as List).cast(); // 顶部轮播组件数
                                return Container(
                                  child:
                                      SwiperDiy(swiperDataList: swiperDataList),
                                );
                              } else {
                                return Container(
                                    height: ScreenUtil().setHeight(255.0),
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
                        ],
                      )),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: StaggeredGridView.countBuilder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
                          ),
                        ),
                      )
                    ],
                  ))),
        ));
  }

//上拉刷新数据
  Future<Null> _refreshData() async {
    _page = 1;
    getThreams();
  }

  //下拉加载更多
  Future<Null> _addMoreData() async {
    _page++;
    getThreams();
  }

  //
  _getLoginInfo() async {
    if (SpUtil.getSp() != null) {
      token = SpUtil.getSp().get('token');
    }
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
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                  //修饰黑色背景与圆角
                  decoration: new BoxDecoration(
                    color: GlobalConfig.bgColor2,
                    borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  ),
                  height: 32,
                  child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: InkWell(
                        onTap: () {
                          if (token == null) {
                            Toast.show("请先登录");
                          } else {
                            Application.router.navigateTo(context, '/searchPage');
                          }
//                    var data = SpUtil.isLogin();
//                    print(data);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/image/search.png",
                                width: 16.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  '请输入您想搜索的内容',
                                  style:
                                  TextStyle(color: Colors.black38, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    onTap: () {
                      if (token == null) {
                        Toast.show("请先登录");
                      } else {
                        Application.router.navigateTo(context, '/personalCenterPage');
                      }
                    },
                    child: Image.asset(
                      'assets/image/userthream.png',
                      width: 24,
                    ),
                  ))
            ],
          ),
        ),
        Container(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[

            ],
          ),
        )
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
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Color.fromARGB(20, 0, 0, 0),
                ),
              ],
//              border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(201),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.elliptical(5, 5)),
                    image: DecorationImage(
                        image: item.image.length == 0
                            ? AssetImage(
                                'assets/image/threabg.png',
                              )
                            : item.image[0].toString().contains('mp4')
                                ? NetworkImage(
                                    '${item.image[0]}?x-oss-process=video/snapshot,t_7000,f_jpg,w_800,h_600,m_fast',
                                  )
                                : NetworkImage(
                                    item.image[0],
                                  ),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment(-1, -1),
                          margin: EdgeInsets.only(bottom: 7.0),
                          child: Text(
                            item.title,
                            style: TextStyle(
                                color: Color(0xFF4C5772), fontSize: 14.0),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipOval(
                                child: item.userHeadImg == ''
                                    ? Image.asset(
                                        'assets/image/hd.png',
                                        width: 16.0,
                                        height: 16.0,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        item.userHeadImg,
                                        width: 16.0,
                                        height: 16.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4.0),
                                child: Text(
                                  '${item.userName}',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12.0),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                    item.likeCount == 0
                                        ? 'assets/image/zan.png'
                                        : 'assets/image/iszan.png',
                                    width: 13,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    item.likeCount.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF3394F2), fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(7.0, 10.0, 7.0, 10.0),
                ),
              ],
            ),
          ),
        );
      } else {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, '/articleDetailPage?id=${item.id}');
          },
          child: Container(
            width: ScreenUtil().setWidth(335),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Color.fromARGB(20, 0, 0, 0),
                ),
              ],
//              border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: 0,

                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(50)
                    ),
                    child: Image.asset(
                      'assets/image/question.png',
                      width: 40,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(7.0, 11.0, 7.0, 11.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(2.0, 0, 2.0, 1.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: Color(0xFF63A4F4),
                            ),
                            child: Text(
                              '问答',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 7.0),
                            padding: EdgeInsets.fromLTRB(2.0, 0, 2.0, 1.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: Color(0xFFA0C7F8),
                            ),
                            child: Text(
                              item.plateName.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment(-1, -1),
                        margin: EdgeInsets.only(bottom: 13.0, top: 8.0),
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF4C5772),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ClipOval(
                                  child: item.userHeadImg == ''
                                      ? Image.asset(
                                          'assets/image/hd.png',
                                          width: 16.0,
                                          height: 16.0,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          item.userHeadImg,
                                          width: 16.0,
                                          height: 16.0,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    item.userName,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12.0),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 5.0, bottom: 1.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: GlobalConfig.primaryColor1, width: 0.5)),
                              child: Text("去解答",
                                  style: TextStyle(
                                      color: GlobalConfig.primaryColor1,
                                      fontSize: 12.0)),
                            )
                          ],
                        ),
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

//轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            color: Color.fromARGB(20, 0, 0, 0),
          ),
        ],
//              border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 0.0, left: 11.0, right: 11.0),
      height: ScreenUtil().setHeight(255),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
//                      borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
                    image: DecorationImage(
                  image: NetworkImage(
                    "${swiperDataList[index]['img']}",
                  ),
                  fit: BoxFit.fill,
                )),
              );
            },
            itemCount: swiperDataList.length,
            autoplay: true,
          ),
        ),
      ),
    );
  }
}
