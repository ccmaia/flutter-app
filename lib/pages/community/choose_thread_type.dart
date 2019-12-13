import 'package:flutter/material.dart';
import '../../routers/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/routes.dart';
import 'put_thread.dart';

class ChoosethreadType extends StatefulWidget {
  @override
  _ChoosethreadTypeState createState() => _ChoosethreadTypeState();
}

class _ChoosethreadTypeState extends State<ChoosethreadType> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
//      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 100,
            child:Container(
              width: ScreenUtil().setWidth(720),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      Application.router.navigateTo(context, "/putThreadPage?groups=1");
                    },
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/image/thread.png",width: 60,),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text("帖子",
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: ScreenUtil().setSp(30)
                            ),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Application.router.navigateTo(context, "/putThreadPage?groups=2");
                      },
                      child: Column(
                        children: <Widget>[
                          Image.asset("assets/image/problem.png",width: 60),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("提问",
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: ScreenUtil().setSp(30)
                              ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            width: ScreenUtil().setWidth(720),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.clear ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )


        ],
      ),
    );
  }
}
