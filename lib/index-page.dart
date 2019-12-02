import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //适配

import 'screen/course.dart';
import 'screen/find_work.dart';
import 'screen/put_work.dart';
import 'screen/community.dart';
import 'screen/my.dart';

class ZncIndexPage extends StatefulWidget {
  _IndexPageWidgetState createState() => _IndexPageWidgetState();
}

class _IndexPageWidgetState extends State<ZncIndexPage> {
  PageController _pageController;

  int _currentIndex = 2;
  final _bottomNavigationIconColor = Colors.grey; // 导航默认图标颜色
  final _bottomNavigationActiveIconColor = Colors.blue; // 导航选中图标颜色
  var currentPage;
  List<StatefulWidget> PageList = [
    Course(),
    PutWork(),
    Community(),
    FindWork(),
    MyPage()
  ];

  @override
  void initState() {
    currentPage = PageList[_currentIndex];
    _pageController = new PageController()
      ..addListener(() {
        if (currentPage != _pageController.page.round()) {
          setState(() {
            currentPage = _pageController.page.round();
          });
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//    print('设备宽度:${ScreenUtil.screenWidth}');
//    print('设备高度:${ScreenUtil.screenHeight}');
//    print('设备像素密度:${ScreenUtil.pixelRatio}');

    final List<BottomNavigationBarItem> _bottomBar = [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: getColor(0),
          ),
          title: Text('课程', style: TextStyle(color: getColor(0)))),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: getColor(1),
          ),
          title: Text('兼职', style: TextStyle(color: getColor(1)))),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.home,
            color: Colors.transparent,
          ),
          title: Text('社区', style: TextStyle(color: getColor(2)))),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: getColor(3),
          ),
          title: Text('求职', style: TextStyle(color: getColor(3)))),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: getColor(4),
          ),
          title: Text('我的', style: TextStyle(color: getColor(4)))),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: PageList,
      ), //页面是否需要重新加载
//      currentPage,
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 60,
        width: 60,
        padding: EdgeInsets.all(5),
        // margin: EdgeInsets.only(bottom:5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Colors.white,
        ),
        child: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            child: Image.asset('assets/image/community.png')
            // Icon(
            //   IconData(0xe682, fontFamily: 'MyIcons'),
            //   color: getColor(2),
            //   size: 55,
            // )
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBar,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            currentPage = PageList[_currentIndex];
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Color getColor(int index) {
    return this._currentIndex == index
        ? _bottomNavigationActiveIconColor
        : _bottomNavigationIconColor;
  }
}
