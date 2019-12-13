import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/public/ToastUtil.dart';
import 'package:flutter_app_test/routers/application.dart';
import '../service/service_method.dart';
import '../public/threaData.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchContent = new TextEditingController();
  List searchThreamList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFileWidget(),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: searchThreamList.length,
//            itemExtent: 100,
            itemBuilder: (BuildContext context,int index){
              return InkWell(
                onTap: (){
                  Application.router.navigateTo(context, '/articleDetailPage?id=${searchThreamList[index].id}');
                },
                child: itemThream(searchThreamList[index]),
              );
        }),
      ),
    );
  }

  void searchthream(){
    if(!_searchContent.text.isEmpty){
      var params = {
        "key": _searchContent.text,
        "_b":1,
        "_e":100
      };
      getNet('searchThrem',data: params).then((res){
        setState(() {
          threamData list = threamData.formJson(res['data']);
          searchThreamList = list.data;
          print(searchThreamList.length);
          if(searchThreamList.length==0){
            Toast.show('暂无信息');
          }
        });
      });
    }else{
      Toast.show('请输入搜索内容');
    }
  }


//  帖子列表
  Widget itemThream(item){
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: item.userHeadImg == ''
                        ? Image.asset(
                      'assets/image/hd.png',
                      width: 22.0,height: 22.0,
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      item.userHeadImg,
                      width: 22.0,height: 22.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Text(
                      item.userName,
                      style: TextStyle(
                          color: Color(0xFFB3B3B3), fontSize: 14.0),
                    ),
                  )
                ],
              ),
              Text(
                '${DateTime.fromMillisecondsSinceEpoch(item.date).toString().split(' ')[0]}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFFB3B3B3), fontSize: 14.0),
              ),
            ],
          ),
          Container(
            child: Text(item.title,textAlign: TextAlign.left,),
            margin: EdgeInsets.only(top: 8.0),
          )
        ],
      ),
    );
  }

  //appbar搜索栏输入框
  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
//      cursorColor: Colors.white, //设置光标
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.only(left: 0.0),
//            fillColor: Colors.white,
          border: InputBorder.none,
          icon: ImageIcon(
            AssetImage(
              "assets/image/search.png",
            ),size: 20,color: Colors.black54,
          ),
          hintText: "请输入搜索内容",
          focusColor: Colors.black54,

//          hintStyle: new TextStyle(fontSize: 14, color: Colors.black54)
      ),
      style: new TextStyle(fontSize: 14),
      controller: _searchContent,
    );
  }
  Widget editView() {
    return Container(
      //修饰黑色背景与圆角
      decoration: new BoxDecoration(
//          border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
        color: Color(0xFFEEEEEE),
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
      ),
      alignment: Alignment.center,
      height: 36,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: buildTextField(),
    );
  }

  @override
  Widget TextFileWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: editView(),
          flex: 1,
        ),
        Container(
          padding: EdgeInsets.only(left: 8,right: 8),
          margin: EdgeInsets.only(left: 5),
          decoration: new BoxDecoration(
//          border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
            color: Colors.blue,
            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
          ),
          height: 36,
          child: Center(
            child: InkWell(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());  //隐藏键盘
                  searchthream();
              },
              child: Text(
                "确定",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        )
      ],
    );
  }



}


