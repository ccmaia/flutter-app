import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../public/base.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routers/application.dart'; //路由
import 'package:provider/provider.dart';
import '../provider/base_list_provider.dart'; //状态管理器

import '../service/httpHeaders.dart';
import '../service/service_method.dart';

class Community extends StatefulWidget {
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<Community> with AutomaticKeepAliveClientMixin {
  String showText = '还没有请求数据';

  @override
  bool get wantKeepAlive => true; //保持页面状态不刷新

  @override
  void initState() {
    super.initState();
    print('页面初始化------');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        body: ListView(
      children: <Widget>[
        searchWidgrt(),
//        FutureBuilder(
//          future: getBannerInfo(),
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              var data = snapshot.data['data']['list'];
//              List<Map> swiperDataList = (data as List).cast(); // 顶部轮播组件数
//              return Column(
//                children: <Widget>[
//                  SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
//                ],
//              );
//            } else {
//              return Container(
//                  height: 150.0,
//                  child: Center(
//                    child: Text('loding'),
//                  ));
//            }
//          },
//        ),
        Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildButton('/eachview', 'assets/image/link-1.png', '在线课堂'),
              _buildButton('/eachview', 'assets/image/link-2.png', '人才招聘'),
              _buildButton('/eachview', 'assets/image/link-3.png', '我要接单'),
              _buildButton('/eachview', 'assets/image/link-4.png', '权威认证')
            ],
          ),
        ),
        RaisedButton(
          onPressed: _jike,
          child: Text('请求数据……'),
        ),
        Text(showText),
//            Provide<Counter>(
//              builder: (context,child,counter){
//                return Text('${counter.value}');
//              },
//            )
      ],
    ));
  }

  void _jike() {
    print('开始向极客时间请求数据..................');
    getHttp().then((val) {
      setState(() {
        showText = val['data']['list'][0]['banner_title'].toString();
      });
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response = await dio.get(
        "https://time.geekbang.org/serv/v2/explore/getBannerList",
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  RaisedButton _buildButton(String route, String url, String label) {
    return RaisedButton(
      onPressed: () {
        //  Navigator.of(context).pushNamed(route);
        // String data = label;
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>new EachView(data)));
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

  Widget searchWidgrt() {
    return new Container(
      padding: EdgeInsets.all(10.0),
      height: 60.0,
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
                      //  data = 1000;
                      Application.router.navigateTo(context, '/searchPage');
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>new SearchPage()));
                    },
                    child: Container(
                      height: 30.0,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search, color: Colors.black54, size: 24.0),
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
              icon: Icon(Icons.unfold_less),
              color: Colors.black54,
            ),
            // height: 14.0,
            width: 30.0,
          ),
          new Container(
              width: 30.0,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.unarchive),
                color: Colors.black54,
              ))
        ],
      ),
    );
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
      ),
      height: ScreenUtil().setWidth(350),
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
