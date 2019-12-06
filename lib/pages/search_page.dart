import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchContent = new TextEditingController();
  String content = '';


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
//          padding: EdgeInsets.all(5.0),
            itemCount: 10,
            itemBuilder: (BuildContext context,int index){
              return Text(content);
        }),
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
                setState(() {
                  content = _searchContent.text;
                });
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


