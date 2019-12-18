import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../service/service_method.dart';
//import '../../public/play_video.dart';

class CourseMsg extends StatefulWidget {
//  String id;
//  CourseMsg(this.id);
  @override
  _CourseMsgState createState() => _CourseMsgState();
}

class _CourseMsgState extends State<CourseMsg> {
  VideoPlayerController controller;
  ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void deactivate() {
    controller.dispose();
    chewieController.dispose();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    print('销毁');
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('课程详情'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: getNet('getCourse',path: '/1'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data['data'];
            controller = VideoPlayerController.network(data['video']);
            chewieController = ChewieController(
              videoPlayerController: controller,
              aspectRatio: 16 / 9,
              autoInitialize: true,
              autoPlay: false,
              looping: false,
              placeholder: new Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            '${data['video']}?x-oss-process=video/snapshot,t_0,f_jpg,w_800,h_600,m_fast'),
                        fit: BoxFit.cover)),
              ),
              // 拖动条样式颜色
              materialProgressColors: new ChewieProgressColors(
                playedColor: Colors.green,
                handleColor: Colors.blue,
                backgroundColor: Colors.grey,
                bufferedColor: Colors.lightGreen,
              ),
            );
            print('课程详情${data}');
            return _contentWidget(data);
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
    );
  }

  // 内容widget
  Widget _contentWidget(data) {
    return Column(
      children: <Widget>[
        Container(
            width: ScreenUtil().setWidth(720),
            height: ScreenUtil().setHeight(408),
            child: new Chewie(
              controller: chewieController,
            )),
        Expanded(
          child: Container(
            width: ScreenUtil().setWidth(720),
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    '课程简介',
                    style: TextStyle(fontSize: 18, color: Color(0xFF333333)),
                  ),
                  margin: EdgeInsets.only(bottom: 13),
                ),
                Text(
                  '${data['author']}：${data['describe']}',
                  style: TextStyle(
                      color: Color(0xFF666666)
                  ),),

              ],
            ),
          ),
        )
      ],
    );
  }


}
