import 'package:flutter/material.dart';
import 'package:flutter_app_test/routers/application.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';
import '../../public/public_select_input.dart';
import 'dart:io';
import '../../public/base.dart';
import 'package:dio/dio.dart';
import 'package:photo_view/photo_view.dart';
import '../../service/service_method.dart';
import '../../public/ToastUtil.dart';
import '../../public//play_video.dart';
import '../../public/photo_view.dart';

class PutThread extends StatefulWidget {
  String groups;

  PutThread(this.groups);

  @override
  _PutThreadState createState() => _PutThreadState();
}

class _PutThreadState extends State<PutThread> {
  String plate = "";
  List mediaList = ["", ""];
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  VideoPlayerController controller;
  List plateList = [];
  String plateName = '';
  List brandList = [];
  String brandName = '';
  String brand = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNet("getThreadPlate").then((res) {
      if(res['result'] == 1) {
        plateList = res['data'];
      }
    });
    getNet('getBrand').then((res){
      if(res['result'] == 1){
        brandList = res['data'];
      }
      print(brandList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.groups == "1" ? "发布帖子" : "发布问题"),
        elevation: 1.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 0),
            color: Colors.white,
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mediaList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 1.0),
                itemBuilder: (BuildContext context, index) {
                  return buildItem(index);
                }),
          ),
          Container(
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0),
                  child: TextField(
                    style: TextStyle(fontSize:16,textBaseline: TextBaseline.alphabetic),
                    decoration: InputDecoration(
                      hintText: "加个标题会有更多人赞哦~",
                      border: InputBorder.none,
                    ),
                    controller: title,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: TextField(
                    style: TextStyle(fontSize:14,textBaseline: TextBaseline.alphabetic),
                    //设置此参数让TextField光标和hint在中文环境下对齐，原理未知
                    maxLines: 6, //设置此参数可以将文本框改为多行文本框
                    decoration: InputDecoration(
                        hintText: "在此输入你想说的内容吧~",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        fillColor: Color(0xFFEBEBEB),
                        filled: true,
                        focusColor: Colors.grey,),
                    controller: content,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  color: Colors.white,
                  child: StoreSelectTextItem(
                      title: "关联品牌",
                      content: brandName.toString(),
                      onTap: () {
                        _showBottomSheetBrand();
                      }),
                ),
                Container(
                  color: Colors.white,
                  child: StoreSelectTextItem(
                      title: "添加类型",
                      content: plateName.toString(),
                      onTap: () {
                        _showBottomSheetPlate();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70, right: 70, top: 80),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF36A4F2), Color(0xFF2A5CF6)]),
                    ),
                    child: RaisedButton(
                        color: Colors.transparent,
//                        padding: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
                        child: Text("发   布", style: TextStyle(fontSize: 18)),
                        textColor: Colors.white,
                        elevation: 0.0,
                        highlightElevation: 0.0,
                        onPressed: _saveThread),
//                    alignment: Alignment.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(index) {
    if (index == mediaList.length - 2) {
      return Container(
        decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.grey[600],
              ),
              Text(
                "添加图片",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              )
            ],
          ),
          onTap: getImage,
        ),
      );
    } else if (index == mediaList.length - 1) {
      return Container(
        decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.grey[600],
              ),
              Text(
                "添加视频",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              )
            ],
          ),
          onTap: getVideo,
        ),
      );
    } else {
      if (mediaList[index].toString().contains("jpg")) {
        return Stack(
          children: <Widget>[
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    image: DecorationImage(
                        image: NetworkImage(mediaList[index]),
                        fit: BoxFit.fill)),
              ),
              onTap: () {
                List imgList = [];
                mediaList.forEach((item) {
                  if (item.toString().contains("jpg")) {
                    imgList.add(item);
                  }
                });
                final i = imgList.indexOf(mediaList[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new PhotoViewGalleryScreen(
                              images: imgList,
                              index: i,
                              heroTag: mediaList[index],
                            )));
              },
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  print('1');
                  setState(() {
                    mediaList.removeAt(index);
                  });
                },
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.grey,
//                  size: 30,
                ),
              ),
            )
          ],
        );
      } else {
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  image: DecorationImage(
                      image: NetworkImage(
                          "${mediaList[index]}?x-oss-process=video/snapshot,t_7000,f_jpg,w_800,h_600,m_fast"),
                      fit: BoxFit.fill)),
              child: Center(
                  child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return VideoAutoPlayWhenReady(mediaList[index]);
                  }));
                },
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.grey,
                  size: 35,
                ),
              )),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  print('1');
                  setState(() {
                    mediaList.removeAt(index);
                  });
                },
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        );
      }
    }
  }

  //  上传图片
  Future getImage() async {
    try {
      Toast.showLong("上传中");
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      String path = image.path;
      var fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
      FormData formData = new FormData.from({
        "file_name": fileName,
        "file": new UploadFileInfo(new File(path), fileName)
      });
      postNet('uploadFile', formData: formData).then((res) {
        print("返回结果${res}");
        if (res['result'] == 1) {
          setState(() {
            mediaList.insert(0, res['data'].toString());
            Toast.cancelToast();
            print(mediaList);
          });
        }
      });
      print('______________________');
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

//  上传视频
  Future getVideo() async {
    try {
      Toast.showLong("上传中");
      var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
      print("选取视频：${video}");
      String path = video.path;
      var fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".mp4";
      FormData formData = new FormData.from({
        "file_name": fileName,
        "file": new UploadFileInfo(new File(path), fileName)
      });
      postNet('uploadVideo', formData: formData).then((res) {
        print("返回结果${res}");
        if (res['result'] == 1) {
          setState(() {
            mediaList.insert(0, res['data'].toString());
            Toast.cancelToast();
            print(mediaList);
          });
        }
      });
      print('______________________');
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

//  发布
  void _saveThread() {
    if (plate == "") {
      Toast.show("请选择板块");
      return;
    }
    if (brand == "") {
      Toast.show("请选择品牌");
      return;
    }
    if (title.text.isEmpty || content.text.isEmpty) {
      Toast.show("请填写标题和内容");
    } else {
      List image = [];
      List video = [];
      mediaList.forEach((item) {
        if (item != '') {
          if (item.toString().contains("mp4")) {
            video.add(item);
          } else {
            image.add(item);
          }
        }
      });
      FormData formData = new FormData.from({
        "title": title.text,
        "describe": content.text,
        "groups": widget.groups,
        "plate": plate,
        "brand":brand,
        "image": image.length > 0 ? image.join(',').toString() : '',
        "video": video.length > 0 ? video.join(',').toString() : '',
      });
      postNet('upLoadThread', formData: formData).then((res) {
        if (res['result'] == 1) {
          Toast.show('发布成功');
          Navigator.pop(context);
          Application.router
              .navigateTo(context, '/articleDetailPage?id=${res['data']}');
          print(res);
        }
      });
    }
  }


//底部弹出品牌框
  void _showBottomSheetBrand() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 310,
            child: ListView.builder(
//              key: const Key('tag'),
              itemExtent: 44.0,
              itemBuilder: (_, index) {
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(brandList[index]['name'].toString()),
                  ),
                  onTap: () {
                    setState(() {
                      brand = brandList[index]["id"].toString();
                      brandName = brandList[index]["name"];
                    });
                    Navigator.pop(context);
                  },
                );
              },
              itemCount: brandList.length,
            ),
          );
        });
  }

//底部弹出类型框
  void _showBottomSheetPlate() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: ListView.builder(
              key: const Key('tag'),
              itemExtent: 44.0,
              itemBuilder: (_, index) {
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(plateList[index]["name"]),
                  ),
                  onTap: () {
                    setState(() {
                      plate = plateList[index]["id"].toString();
                      plateName = plateList[index]["name"];
                    });
                    Navigator.pop(context);
                  },
                );
              },
              itemCount: plateList.length,
            ),
          );
        });
  }
}
