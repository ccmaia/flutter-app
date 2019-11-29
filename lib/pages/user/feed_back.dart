import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '意见反馈',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Container(
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
      child: Material(
        color: Color.fromRGBO(49, 175, 255, 1),
        child: new MaterialButton(
            onPressed: _launchPhone,
            textColor: Colors.white,
            child: Text(
              "联系我们:10086",
              style: TextStyle(fontSize: 18),
            )),
        borderRadius: BorderRadius.circular(50.0),
        shadowColor: Colors.grey,
        elevation: 5.0,
      ),
    );
  }
}

_launchPhone() async {
  const url = 'tel:10086';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
