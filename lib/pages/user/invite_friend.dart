import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '邀请有奖',
            style: TextStyle(
              color: Colors.white,
            ),
          ),

          backgroundColor: Colors.lightBlue,
          centerTitle: true,
        ),
        body: ListView(
        ));
  }
}
