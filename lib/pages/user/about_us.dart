import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../public/base.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 720, height: 1280)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '关于我们',
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(ScreenUtil().setWidth(45.0)),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 25.0),
                    child: Image.asset(
                      'assets/image/logo1.png',
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    '        杭州指南车机器人科技有限公司成立于2015年，总部杭州，业务分布在全国十几个城市。 目前已与近百家工业机器人集成商达成合作，公司拥有多项国家专利和数十名来自工业机 器人行业的专业人才。',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(26.0),
                      height: 1.5,
                    ),
                  ),
                  Text(
                    '        在工业 4.0和中国制造2025背景下，为助力中国大量传统制造业企 业完成“机器换人”改造，指南车机器人教育为行业培养并输送高端工程师，同时也为使用工业机器人的客户提供保姆级别的售后技术服务。2017年成立指南车智能系统公司，专注于设计及研发MHLSS(生产制造健康与生命维持云平台系统)、指南车SCADA、 指南车MES等系统。',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(26.0),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(750),
                    height: 10.0,
                    color: GlobalConfig.bgColor2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setSp(45.0),
                        top: ScreenUtil().setHeight(30.0),
                        bottom: ScreenUtil().setHeight(30.0)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "电话：",
                          style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),
                        ),
                        Text(
                          "  400-8618755",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: ScreenUtil().setSp(28.0)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(750),
                    height: 1.0,
                    color: GlobalConfig.bgColor2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setSp(45.0),
                        top: ScreenUtil().setHeight(30.0),
                        bottom: ScreenUtil().setHeight(30.0)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "网址：",
                          style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),
                        ),
                        Text(
                          "  zhinanche.com",
                          style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(750),
                    height: 1.0,
                    color: GlobalConfig.bgColor2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setSp(45.0),
                      top: ScreenUtil().setHeight(30.0),
                    ),
                    child: Container(
                        height: 100.0,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: ScreenUtil().setWidth(86.0),
                              child: Text(
                                "地址：",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(28.0)),
                              ),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(540),
                              child: Text(
                                "浙江省杭州市余杭区文一西路1818-2号人工智能小镇1号楼4楼",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(28.0)),
                                softWrap: true,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
