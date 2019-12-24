import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';
import 'package:flutter_app_test/routers/application.dart';
import 'package:flutter_app_test/service/service_method.dart';
import '../../public/certData.dart';

class inquire extends StatefulWidget {
  @override
  _inquireState createState() => _inquireState();
}

class _inquireState extends State<inquire> {
  TextEditingController _searchContent = new TextEditingController();
  Map certInfo = {};
  bool haveInfo = false;
  bool showNoMsg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('认证查询'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
//          shrinkWrap: true,
//          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            TextFileWidget(),
            haveInfo && !showNoMsg
                ? haveCert()
                : !haveInfo && showNoMsg ? noCert() : Container()
          ],
        ),
      ),
    );
  }

  Widget TextFileWidget() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              //修饰黑色背景与圆角
              decoration: new BoxDecoration(
//          border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
                color: Color(0xFFEEEEEE),
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              ),
              alignment: Alignment.center,
              height: 32,
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: new EdgeInsets.only(left: 0.0),
                    border: InputBorder.none,
                    icon: ImageIcon(
                      AssetImage(
                        "assets/image/search.png",
                      ),
                      size: 16,
                      color: Colors.black54,
                    ),
                    hintText: "请输入身份证号或证书编号",
                    hintStyle:
                        new TextStyle(fontSize: 14, color: Colors.black54)),
                style: new TextStyle(
                  fontSize: 14,
                  color: Colors.black38,textBaseline: TextBaseline.alphabetic
                ),
                controller: _searchContent,
              ),
            ),
            flex: 1,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
            margin: EdgeInsets.only(left: 6),
            height: 32,
            child: Center(
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode()); //隐藏键盘
                  searchCertify();
                },
                child: Text(
                  "确定",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget haveCert() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFEDF7FF)),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/image/znc-cert.png",width: 185,),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text('恭喜您！通过指南车认证。授予工业机器人应用工程师（通用调试）证书',style: TextStyle(fontSize: 14,height: 1.5),),
                padding: EdgeInsets.all(15),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFE5E5E5),width: 1)
                    )
                ),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 5),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    RowWidget('姓名', certInfo['name']),
                    RowWidget('认证方向', certInfo['course']['name'].toString().substring(1)),
                    RowWidget('证书编号', certInfo['cert_code'].toString()),
                    RowWidget('考试分数', certInfo['score'].toString()),
                    RowWidget('认证时间', '${DateTime.fromMillisecondsSinceEpoch(certInfo['create_time']).toString().split(' ')[0]}'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget noCert() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Image.asset('assets/image/umpty-img.png'),
          ),
          Text('暂无证书消息',style: TextStyle(fontSize: 16,color: Colors.black),),
          Text('快去参加证书认证吧！',style: TextStyle(fontSize: 16,color: Color(0xFF999999)),),
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
                      onPressed: (){
                        Navigator.pop(context);
                        Application.router.navigateTo(context, '/registerPage');
                      }),
//                    alignment: Alignment.center,
                ),
              )
          )
        ],
      ),
    );
  }

  Widget RowWidget(label, content) {
    return Row(
      children: <Widget>[
        Container(
          width: 80,
          child: Text(
            label,
            style: TextStyle(color: Color(0xFF999999),height: 1.5),
          ),
        ),
        Text(
          content,
          style: TextStyle(height: 1.5),
        )
      ],
    );
  }

  void searchCertify() {
    if (_searchContent.text.isEmpty) {
      Toast.show("请输入内容");
    } else {
      FormData formData = FormData.from({"code": _searchContent.text});
      getNet('cert', data: formData).then((res) {
//        print(res);
        if (res['result'] == 1) {
          setState(() {
            List list = res['data'];
            if (list.length > 0) {
              certInfo = res['data'][0];
              haveInfo = true;
              showNoMsg = false;
            } else {
              certInfo = {};
              haveInfo = false;
              showNoMsg = true;
            }
          });
        }
      });
    }
  }
}
