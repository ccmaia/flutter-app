import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///播放视频

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
  ChewieController chewieController;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    print("url is ${widget.url}");
    controller = VideoPlayerController.network(widget.url);
    chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: 3 / 2,
        autoInitialize: true,
        autoPlay: true,
//        looping: false
    );
    controller.setLooping(true);
    controller.setVolume(0.0);
    controller.addListener(() {
      if (!mounted) {
        return;
      }
    });
    controller.play();
    controller.initialize().then((value) {
      setState(() {
        _isInit = controller.value.initialized;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  ///创建播放中的视频界面
  Widget _buildPlayingWidget() {
    return AspectRatio(
        aspectRatio: 3 / 2,
        child: GestureDetector(
          onTap: () {
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
  Widget _buildInitingWidget() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Stack(
        children: <Widget>[
          VideoPlayer(controller),
          const Center(
              child: CircularProgressIndicator()
          ),
        ],
        fit: StackFit.expand,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('播放视频'),
      ),
      body: Center(
          child: _isInit
              ?  new Chewie(controller: chewieController,)
              : _buildInitingWidget()),
      //            new Chewie(controller: chewieController,)    _buildPlayingWidget()

//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          setState(() {
//            controller.value.isPlaying ? controller.pause() : controller.play();
//          });
//        },
//        child: Icon(
//          controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//        ),
//      ),
    );
  }
}
