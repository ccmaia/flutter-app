import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../public/public_select_input.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../service/service_method.dart';
import '../../public/ToastUtil.dart';

class PutThread extends StatefulWidget {
  String groups;
  PutThread(this.groups);

  @override
  _PutThreadState createState() => _PutThreadState();
}

class _PutThreadState extends State<PutThread> {
  String tag = "0";
  List mediaList = [
    "",
    ""
  ];
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.groups);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groups == "1" ? "发布帖子" : "发布问题"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: StoreSelectTextItem(
                title: "请选择类型",
                content: tag == "0"
                    ? ""
                    : tag == "1"
                        ? "ABB"
                        : tag == "2" ? "西门子" : tag == "3" ? "库卡" : "安川",
                onTap: () {
                  _showBottomSheet();
                }),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0),
              child: ListView(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "请输入你的标题", //占位文字
                    ),
                    controller: title,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    maxLines: 3, //设置此参数可以将文本框改为多行文本框
                    decoration: InputDecoration(
                        labelText: "请输入你的描述",
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFFEBEBEB)),
                    controller: content,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: GridView.builder(
                        itemCount: mediaList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.0),
                        itemBuilder: (BuildContext context, index) {
                          return buildItem(index);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                    child:
                    Container(
                      width: 220,
                      height: 45,
//                margin: EdgeInsets.only(left: ScreenUtil().setWidth(80.0)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(45.0)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF36A4F2), Color(0xFF2A5CF6)]),
                      ),
                      child: RaisedButton(
                          color: Colors.transparent,
//                        padding: EdgeInsets.all(ScreenUtil().setWidth(15.0)),
                          child: Text("发布",
                              style: TextStyle(fontSize: 20)),
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
          )
        ],
      ),
    );
  }

  Widget buildItem(index) {
    print(index);
    if (index == mediaList.length-2) {
      return Container(
        decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.add,color: Colors.grey[600],),
              Text("添加图片",style: TextStyle(fontSize: 10,color: Colors.grey),)
            ],
          ),
          onTap: getImage,
        ),
      );
    }else if(index == mediaList.length-1) {
      return Container(
        decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.add,color: Colors.grey[600],),
              Text("添加视频",style: TextStyle(fontSize: 10,color: Colors.grey),)
            ],
          ),
          onTap: getVideo,
        ),
      );
    }else{
      if (mediaList[index].toString().contains("jpg")) {
        return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.elliptical(5, 5)),
              child: Image.network(
                mediaList[index],
                fit: BoxFit.fill,
              ),
            ));
      }

    }
  }
  //  上传图片
  Future getImage() async {
    try {
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
  Future getVideo() async{
    try {
      var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
      print("选取视频：${video}");
      String path = video.path;
      var fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".mp4";
      FormData formData = new FormData.from({
        "file_name": fileName,
        "file": video
      });
      postNet('uploadVideo', formData: formData).then((res) {
        print("返回结果${res}");
        if (res['result'] == 1) {
          setState(() {
            mediaList.insert(0, res['data'].toString());
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
  void _saveThread(){
    if(title.text.isEmpty||content.text.isEmpty){
      Toast.show("请填写标题和内容");
    }else{
      FormData formData  = new FormData.from({
        "title":title,
        "desc":content,
        "groups":widget.groups,
        "tag":"",
        "image":"",
        "video":""
      });
//      postNet('upLoadThread')
    }
  print(title.text.isEmpty);
  }


  List tagList = [
    {
      "id": "1",
      "tag": "ABB",
    },
    {
      "id": "2",
      "tag": "西门子",
    },
    {
      "id": "3",
      "tag": "库卡",
    },
    {
      "id": "4",
      "tag": "安川",
    },
  ];
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 300,
            child: ListView.builder(
              key: const Key('tag'),
              itemExtent: 48.0,
              itemBuilder: (_, index) {
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(tagList[index]["tag"]),
                  ),
                  onTap: () {
                    setState(() {
                      tag = tagList[index]["id"];
                    });
//                NavigatorUtils.goBack(context);
                    Navigator.pop(context);
                  },
                );
              },
              itemCount: tagList.length,
            ),
          );
        });
  }
}
