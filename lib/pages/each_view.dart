import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class EachView extends StatefulWidget {
  final String data;
  EachView(this.data);
  _EachViewState createState() => _EachViewState();
}

class _EachViewState extends State<EachView> {
  final _inputDecoration = InputDecoration(
      contentPadding: EdgeInsets.all(10.0),
      icon: Icon(Icons.accessibility_new),
      suffixIcon: Icon(Icons.chevron_right),
      hintText: '请输入性别');

  TextEditingController typeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String showText = '欢迎你来到美好人间';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('美好人间'),
          ),
          body: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: typeController,
                  decoration: _inputDecoration,
                  autofocus: false,
                ),
                TextField(
                    controller: nameController, decoration: _inputDecoration),
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('输入完毕'),
                ),
                Text(
                  widget.data,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
          )
      ),
    );
  }

  void _choiceAction() {
    print({'sex': typeController.text, 'name': nameController.text});
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('内容不能为空')));
    } else {
      // getHttp(typeController.text.toString()).then((val){
      //   print('${val.data}-----------');
      //   setState(() {
      //     showText=val['data']['name'].toString();
      //   });
      // });
    }
  }

  Future getHttp(String TypeText) async {
    try {
      Response response;
//      var data = {'name': TypeText};
      response = await Dio().get(
          "https://www.easy-mock.com/mock/5dcbab285e71c8782d07b36e/app/getUserInfo");
      print('-----------');
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
