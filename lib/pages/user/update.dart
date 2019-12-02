import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() {
    return new _UpdatePageState();
  }
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '版本更新',
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: new BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xffCBE0FF), Color(0xffDED1FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Text(
              'V1.10',
              style: TextStyle(fontSize: ScreenUtil().setSp(50.0), height: 4.5),
            ),
            Text(
              '当前版本',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26.0),
                color: Colors.black,
              ),
            ),
            Center(
              child: LinkView(),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LinkViewState();
  }
}

class LinkViewState extends State<LinkView> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(570.0)),
      height: 44.0,
      child: Material(
        color: Color.fromRGBO(49, 175, 255, 1),
//        color: Color.fromRGBO(210, 210, 210, 1), //暂无更新时的按钮颜色
        child: new MaterialButton(
            height: ScreenUtil().setSp(10.0),
            minWidth: ScreenUtil().setWidth(525.0),
            onPressed: _launchPhone,
            textColor: Colors.white,
            child: Text(
              "发现新版本，立即更新",
              style: TextStyle(fontSize: ScreenUtil().setSp(32.0)),
            )),
        borderRadius: BorderRadius.circular(50.0),
        shadowColor: Colors.grey[500],
        elevation: 2.0,
      ),
    );
  }
}

_launchPhone() async {
  const url = 'https://www.baidu.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw '网络错误';
  }
}
