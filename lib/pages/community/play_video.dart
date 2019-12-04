import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAutoPlayWhenReady extends StatefulWidget {
  String url;
  VideoAutoPlayWhenReady(this.url);
  @override
  State<StatefulWidget> createState() {
    return _VideoState();
  }
}

class _VideoState extends State<VideoAutoPlayWhenReady> {
  VideoPlayerController controller;
  bool _isInit = false;
  @override
  void initState() {
    super.initState();
    print("url is ${widget.url}");
    controller=VideoPlayerController.network(widget.url);
    controller.setLooping(true);
    controller.setVolume(0.0);
    controller.addListener(() {
      if (!mounted) {
        return;
      }
    });
    controller.play();
    controller.initialize().then((value){
      setState(() {
        _isInit = controller.value.initialized;

      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  ///创建播放中的视频界面
  Widget _buildPlayingWidget(){
    return AspectRatio(
        aspectRatio: 3 / 2,
        child:  GestureDetector(
          onTap: (){
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
          child: VideoPlayer(controller),
        ));
  }

  ///视频正在加载的界面
  Widget _buildInitingWidget(){
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Stack(
        children: <Widget>[
          VideoPlayer(controller),
          const Center(child: CircularProgressIndicator()),
        ],
        fit: StackFit.expand,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('视频播放'),
      ),
      body:  Center(
          child:
          _isInit
              ? _buildPlayingWidget()
              :_buildInitingWidget()
      ),
    );

  }
}