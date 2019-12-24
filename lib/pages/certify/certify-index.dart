import 'package:flutter/material.dart';
import 'package:flutter_app_test/routers/application.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class certifyIndex extends StatefulWidget {
  @override
  _certifyIndexState createState() => _certifyIndexState();
}

class _certifyIndexState extends State<certifyIndex> {
  final List swiperDataList = [
    "assets/image/cert-banner-0.png",
    "assets/image/cert-banner-1.png",
    "assets/image/cert-banner-2.png",
  ];
  final List intelligenceList = [
    {'name': '拥有多年的行业理解', 'desc': '认证团队成员均为行业深耕多年的工程师，对机器人自动化应用领域拥有深度理解。'},
    {'name': '认证专家委员会', 'desc': '中科院研究员、高校教授、机器人企业CEO、ABB高级工程师等专家学者，具有权威性'},
    {'name': '深悟企业人才需求', 'desc': '对上千家机器人集成应用企业调研合作，提供了大量的优质人才'},
    {'name': '职业发展需求', 'desc': '已认证1000+机器人自动化工程师，深知工程师对技能和企业认可的需求'},
  ];
  final List examList = [
    '指南车认证网站http://cert.zhinanche.com/home/index.html发布考试信息',
    '考生报名，交报考费，采集信息',
    '发布考试链接，考生前往指南车机器人学院（杭州、昆山、上海、佛山、成都）参加考试',
    '考试完成，收集邮寄地址信息',
    '证书制作，录入信息',
    '邮寄证书'
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('指南车认证'),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          SwiperDiy(swiperDataList: swiperDataList),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Image.asset(
                    'assets/image/cert-0.png',
                    width: 165,
                  ),
                  onTap: (){
                      Application.router.navigateTo(context, '/registerPage');
                  },
                ),
                InkWell(
                  onTap: (){Application.router.navigateTo(context, '/inquirePage');},
                  child: Image.asset(
                    'assets/image/cert-1.png',
                    width: 165,
                  ),
                )
              ],
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            color: Color(0xFFF2F2F2),
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/image/point-left.png",
                      width: 20,
                    ),
                    Text('指南车认证证书'),
                    Image.asset('assets/image/point-right.png', width: 20)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/image/cert-top.png",
                            width: 185,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            width: 185,
                            child: Text(
                              '指南车机器人自动化系统集成认证',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: 185,
                              child: Text(
                                '指南车工业机器人操作员认证',
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.right,
                              ))
                        ],
                      ),
                      Image.asset(
                        "assets/image/cert-left.png",
                        width: 145,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/image/point-left.png",
                      width: 20,
                    ),
                    Text('指南车认证资质'),
                    Image.asset('assets/image/point-right.png', width: 20)
                  ],
                ),
                Container(
//                  height: 250,
                  margin: EdgeInsets.only(top: 10),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //每行2个
                        mainAxisSpacing: 10.0, //主轴方向间距
                        crossAxisSpacing: 10.0, //水平方向间距
                        childAspectRatio: 1.2, //纵轴缩放比例
                      ),
                      itemCount: intelligenceList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0)),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: index % 2 == 0
                                    ? [Color(0xFF558DF6), Color(0xFF616BF4)]
                                    : [Color(0xFF1A9DF7), Color(0xFF5490F6)],
                              )),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                intelligenceList[index]['name'],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                intelligenceList[index]['desc'],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    height: 2),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          Container(
            color: Color(0xFFF2F2F2),
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/image/point-left.png",
                      width: 20,
                    ),
                    Text('考试流程'),
                    Image.asset('assets/image/point-right.png', width: 20)
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF1A9DF7), width: 1.0),
                    borderRadius: BorderRadius.all(const Radius.circular(10.0)),
                    color: Color(0xFFE5E5E5),
                  ),
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: examList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 15,
                                height: 15,
                                margin: EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(20.0)),
                                  color: Color(0xFF1A9DF7),
                                ),
                                child: Center(
                                  child: Text(
                                    index.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(examList[index]),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment(-1, -1),
                  child: Text('备注：',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14)),
                ),
                Text('1.考试通过后证书将在考试完成后2-3周接收到邮寄证书，同时也可通过指南车官网查询到证书信息',
                    style: TextStyle(color: Color(0xFF999999), fontSize: 14,height: 1.5),),
                Text(
                  '2.未通过考试的内部系统班学员请保持联络畅通，等待下次补考通知',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 14,height: 1.5),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//轮播图widget
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
//                      borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
                image: DecorationImage(
              image: AssetImage(
                "${swiperDataList[index]}",
              ),
              fit: BoxFit.fill,
            )),
          );
        },
        itemCount: swiperDataList.length,
        autoplay: true,
      ),
    );
  }
}
