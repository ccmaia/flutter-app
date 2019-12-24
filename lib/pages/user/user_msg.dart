import 'package:flutter/material.dart';
import 'package:flutter_app_test/routers/application.dart';
import 'package:image_picker/image_picker.dart';
import '../../public/ToastUtil.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../public/public_select_input.dart';
import '../../service/service_method.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../public/base.dart';

class UserMsgPage extends StatefulWidget {
  Map userMsg;

  UserMsgPage(this.userMsg);

  @override
  _UserMsgPageState createState() => _UserMsgPageState();
}

class _UserMsgPageState extends State<UserMsgPage> {
  File _userImg;
  String header_img;
  String phone;
  String name;
  int sex;
  bool img = false;

  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      header_img = widget.userMsg['header_img'];
      name = widget.userMsg['name'];
      sex = widget.userMsg['sex'];
    });
    print("${widget.userMsg}个人信息");
  }

  //  上传图片
  Future getImage() async {
    try {
      setState(() {
        img = true;
      });
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      String path = image.path;
      var fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
      FormData formData = new FormData.from({
        "file_name": fileName,
        "file": new UploadFileInfo(new File(path), fileName)
      });
//      print('上传的数据='+formData.toString());
      postNet('uploadFile', formData: formData).then((res) {
        print("返回结果${res}");
        if (res['result'] == 1) {
//          Toast.show("")
          setState(() {
            header_img = res['data'].toString();
            img = false;
          });
        }
      });
      print('______________________');
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

  String _sortName = "";
  var sexList = ["男", "女"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('个人信息'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 65.0,
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 10.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color:GlobalConfig.borderColor1))),
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
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          image: DecorationImage(
                              image: header_img == null
                                  ? AssetImage("assets/image/not_login.png")
                                  : NetworkImage(
                                      header_img,
                                    ),
                              fit: BoxFit.cover)),
                      child: !img?Text(''):SpinKitCircle(color: Colors.blueAccent, size: 30.0,),
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
                hintText: name),
            StoreSelectTextItem(
                title: "性别",
                content: sex == 1 ? '女' : '男',
                onTap: () {
                  _showBottomSheet();
                }),
            InkWell(
              onTap: () {
                Application.router.navigateTo(context, "/choosePhonePage");
              },
              child: Container(
                height: 65.0,
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: GlobalConfig.borderColor1))),
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
                                    fontSize: 16.0, color: GlobalConfig.fontColor2)),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: Text("${widget.userMsg['phone']}",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color:  GlobalConfig.fontColor2)),
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
                                  fontSize: 14.0, color: GlobalConfig.fontColor2)),
                        ),
                        Image.asset(
                          "assets/image/go_last.png",
                          width: 13.0,
                          height: 20.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print(widget.userMsg['phone'].toString());
//                return;
                Application.router.navigateTo(context,
                    "/choosePassPage?phone=${Uri.encodeComponent(widget.userMsg["phone"].toString())}");
              },
              child: Container(
                height: 65.0,
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: GlobalConfig.borderColor1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('修改密码',
                                style: TextStyle(
                                    fontSize: 16.0, color: GlobalConfig.fontColor2)),
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
                                  fontSize: 14.0, color: GlobalConfig.fontColor2)),
                        ),
                        Image.asset(
                          "assets/image/go_last.png",
                          width: 13.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child:Center(
                child: Container(
                  width: 195,
                  height: 40,
//                margin: EdgeInsets.only(left: ScreenUtil().setWidth(80.0)),
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
                      child: Text("保存信息", style: TextStyle(fontSize: 16)),
                      textColor: Colors.white,
                      elevation: 0.0,
                      highlightElevation: 0.0,
                      onPressed: _chooseMsg),
//                    alignment: Alignment.center,
                ),
              )
            )
          ],
        ));
  }

  void _chooseMsg() {
    print("name is ${userName.text},Sex is ${sex}，header_img is ${header_img}");
    if (userName.text.length > 0) {
      name = userName.text;
    }
    ;
    if (name == null) {
      Toast.show("请填写昵称");
    } else {
      FormData formData =
          new FormData.from({"name": name, "sex": sex, "head_img": header_img});
      putNet("chooseUserMsg", formData: formData).then((res) {
        if (res["result"] == 1) {
          Toast.show('修改成功');
          Navigator.pop(context);
        }
      });
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 100,
            child: ListView.builder(
              key: const Key('sex'),
              itemExtent: 48.0,
              itemBuilder: (_, index) {
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(sexList[index]),
                  ),
                  onTap: () {
                    setState(() {
                      sex = index;
                    });
//                NavigatorUtils.goBack(context);
                    Navigator.pop(context);
                  },
                );
              },
              itemCount: sexList.length,
            ),
          );
        });
  }
}
