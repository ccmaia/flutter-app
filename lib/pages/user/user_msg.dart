import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../public/ToastUtil.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../public/public_select_input.dart';
import '../../service/service_method.dart';

class UserMsgPage extends StatefulWidget {
  Map userMsg;

  UserMsgPage(this.userMsg);

  @override
  _UserMsgPageState createState() => _UserMsgPageState();
}

class _UserMsgPageState extends State<UserMsgPage> {
  File _userImg;
  String head_img;
  String phone;
  String name;
  String sex;

  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userSex = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    head_img = widget.userMsg['head_img'];

    print("${widget.userMsg}个人信息");
  }

  //  上传图片
  Future getImage() async {

    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      String path = image.path;
      setState(() {
        _userImg = image;
        head_img = path;
      });

      FormData formData = new FormData.from({
        "file_name": DateTime.now().millisecondsSinceEpoch,
        "file": new File(path)
      });
      postNet('uploadFile', formData: formData).then((res) {
//        print(res);
      });

      print('______________________');
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }



//      print("flie is ${new UploadFileInfo(new File(path), fileName)}");
//      return;

  @override
  Widget build(BuildContext context) {
    String _sortName = "";
    var sexList = ["男", "女"];
    return Scaffold(
        appBar: AppBar(
          title: Text('个人信息'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 65.0,
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 8.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xFFE5E5E5)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text('头像',
                        style: TextStyle(
                            fontSize: 16.0, color: Color(0xFF5C6784))),
                  ),
                  InkWell(
                    child: Image.asset(head_img==null?
                      'assets/image/not_login.png':head_img,
                      width: 50,
                    ),
                    onTap: getImage,
                  )
                ],
              ),
            ),
            TextFieldItem(
              focusNode: FocusNode(),
              title: "昵称",
              controller: userName,
            ),
            StoreSelectTextItem(
                title: "性别",
                content: _sortName,
                onTap: () {
                  _showBottomSheet();
                }),
            InkWell(
              onTap: () {},
              child: Container(
                height: 65.0,
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 8.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xFFE5E5E5)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('手机号',
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xFF5C6784))),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: Text("${widget.userMsg['phone']}",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xFF999999))),
                            )
                          ],
                        )),
                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Text('去修改',
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xFF999999))),
                        ),
                        Image.asset(
                          "assets/image/go_last.png",
                          width: 10.0,
                          height: 15.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void _showBottomSheet() {}
}
