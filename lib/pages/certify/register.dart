import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';
import 'package:flutter_app_test/service/service_method.dart';
import 'package:dio/dio.dart';
import '../../public/public_select_input.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List directionList = [];
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController mobileCode = TextEditingController();
  int classDirection;
  String classDirectionName = '请选择';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDirection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('认证报名'),
      ),
      body: ListView(
        children: <Widget>[
          TextFieldItem(
              title: "真实姓名：",
              controller: name,
              hintText: '请输入真实姓名'),
          TextFieldItem(
              title: "手机号码：",
              controller: mobile,
              hintText: '请输入手机号'),
          Container(
              height: 55.0,
            padding: EdgeInsets.only(right: 16),
              child: Stack(
                children: <Widget>[
                 TextFieldItem(
                        title: "短信验证：",
                        controller: mobileCode,
                        hintText: ''),

                  Align(
                    alignment: FractionalOffset.centerRight,
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          _getSms();
                        },
                        child: Text(
                          '获取验证码',
                          style: TextStyle(color: Color(0xFF477BFF)),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          StoreSelectTextItem(
              title: "认证课程：",
              content: classDirectionName,
              onTap: () {
                _showBottomSheet();
              }),
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
                      child: Text("确定", style: TextStyle(fontSize: 16)),
                      textColor: Colors.white,
                      elevation: 0.0,
                      highlightElevation: 0.0,
                      onPressed: _sureSave),
//                    alignment: Alignment.center,
                ),
              )
          )
        ],
      ),
    );
  }


//获取认证方向
  void getDirection(){
    getNet('getDirection').then((res){
      print(res);
      if(res['result']==1){
        directionList = res['data'];
      }
    });
  }
//  保存
  void _sureSave(){
    if(!name.text.isEmpty&&!mobile.text.isEmpty&&!mobileCode.text.isEmpty&&classDirection.toString()!=null){
      print('11');
      FormData formData = FormData.from({
        'name': name.text,
        'mobile': mobile.text,
        'classDirection': classDirection,
        'mobileCode': mobileCode.text,
        'type': 5
      });
      postNet('registerSave',formData: formData).then((res){
        print(res);
        if(res['result']==1){
          Toast.show('报名成功');
          Navigator.pop(context);
        }else{
          Toast.show(res['errors']['message']);
        }
      });
    }else{
      Toast.show("请填写完整信息");
    }
  }

  //获取验证码
  void _getSms() {
    if (mobile.text.length == 11) {
      FormData formData = new FormData.from({
        'send': mobile.text,
      });
      postNet('getSMS', formData: formData).then((res) {
        if (res['result'] == 1) {
          Toast.show("验证码发送成功");
        }
      });
    } else {
      Toast.show('请填写正确手机号');
    }
  }

//底部弹出框
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 350,
            child: ListView.builder(
              key: const Key('sex'),
              itemExtent: 48.0,
              itemBuilder: (_, index) {
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(directionList[index]['name']),
                  ),
                  onTap: () {
                    setState(() {
                      classDirection = directionList[index]['id'];
                      classDirectionName = directionList[index]['name'];
                    });
//                NavigatorUtils.goBack(context);
                    Navigator.pop(context);
                  },
                );
              },
              itemCount: directionList.length,
            ),
          );
        });
  }
}
