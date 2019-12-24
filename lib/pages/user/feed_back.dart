import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() {
    return new _FeedBackPageState();
  }
}

class _FeedBackPageState extends State<FeedBackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '意见反馈',
          style: TextStyle(),
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
//          color:Color.fromRGBO(218, 76, 36, 1),
        child: Center(
          child: LinkView(),
        ),
      ),
    );
  }
}

class LinkView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LinkViewState();
  }
}

class LinkViewState extends State<LinkView> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 44.0,
      child: Material(
        color: Color.fromRGBO(49, 175, 255, 1),
        child: new MaterialButton(
            height: ScreenUtil().setSp(10.0),
            minWidth: ScreenUtil().setWidth(525.0),
            onPressed: _launchPhone,
            textColor: Colors.white,
            child: Text(
              "联系我们",
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
  const url = 'tel:4008-616-755';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
