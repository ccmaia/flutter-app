import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: AppBar(
            title: Text(
              '意见反馈',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body: new LinkView()),
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
    return new Column(
      children: <Widget>[
        FlatButton(
            onPressed: _launchPhone,
            child: Text(
              "联系我们",
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ))
      ],
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
