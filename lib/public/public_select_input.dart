import 'package:flutter/material.dart';
import '../public/base.dart';


///选择框
class StoreSelectTextItem extends StatelessWidget {
  const StoreSelectTextItem(
      {Key key,
      this.onTap,
      @required this.title,
      this.content: "",
      this.textAlign: TextAlign.end,
      this.style})
      : super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(right: 16.0, left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, color:GlobalConfig.borderColor1,width: 1),
        )),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 16.0, color: GlobalConfig.fontColor2),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                child: Text(content,
                    maxLines: 2,
                    textAlign: textAlign,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.0, color: GlobalConfig.fontColor2)),
              ),
            ),
            Image.asset(
              "assets/image/go_last.png",
              width: 13.0,
              height: 20.0,
            )
//            Icon(Icons.keyboard_arrow_right)
//            Images.LoadAssetImage("ic_arrow_right", height: 16.0, width: 16.0)
          ],
        ),
      ),
    );
  }
}

/// 封装输入框
class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    Key key,
    @required this.controller,
    @required this.title,
    this.keyboardType: TextInputType.text,
    @required this.hintText,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      margin: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color:GlobalConfig.borderColor1))),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(title,
                style: TextStyle(fontSize: 16.0, color: GlobalConfig.fontColor2,)),
          ),
          Expanded(
            flex: 1,
            child: TextField(
                textAlign: title=='短信验证：'?TextAlign.left:TextAlign.right,
                focusNode: focusNode,
                keyboardType: keyboardType,
                inputFormatters: _getInputFormatters(),
                controller: controller,
                style: TextStyle(fontSize: 14.0, color: GlobalConfig.fontColor2),
                //style: TextStyles.textDark14,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none, //去掉下划线
                  //hintStyle: TextStyles.textGrayC14
                )),
          ),
          title=='短信验证：'?Container():Container(
            margin: EdgeInsets.only(
              left: 10.0,
            ),
            child:
            Image.asset(
              "assets/image/go_last.png",
              width: 13.0,
              height: 20.0,
            ),
          )
        ],
      ),
    );
  }

  _getInputFormatters() {
//    if (keyboardType == TextInputType.numberWithOptions(decimal: true)){
//      return [UsNumberTextInputFormatter()];
//    }
//    if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone){
//      return [WhitelistingTextInputFormatter.digitsOnly];
//    }
    return null;
  }
}
