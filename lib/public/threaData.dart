class threamData {
  List<Data> data;

  threamData( this.data);

  factory threamData.formJson(List json){
    return threamData(
        json.map((i)=>Data.fromJson((i))).toList()
    );
  }
}

class Data {
  int id;
  String title;
  int groups;
  int plate;
  String tag;
  String userName;
  String userHeadImg;
  List<String> image;
  int date;
  String plateName;
  int likeCount;
  int replyCount;

  Data(
      {this.id,
        this.title,
        this.groups,
        this.plate,
        this.tag,
        this.image,
        this.userName,
        this.userHeadImg,
        this.date,
        this.plateName,
        this.likeCount,
        this.replyCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    groups = json['groups'];
    plate = json['plate'];
    tag = json['tag'];
    image = json['image'].cast<String>();
    userName = json['user_name'];
    userHeadImg = json['user_head_img'];
    date = json['date'];
    plateName = json['plateName'];
    likeCount = json['like_count'];
    replyCount = json['reply_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['groups'] = this.groups;
    data['plate'] = this.plate;
    data['tag'] = this.tag;
    data['image'] = this.image;
    data['user_name'] = this.userName;
    data['user_head_img'] = this.userHeadImg;
    data['date'] = this.date;
    data['plateName'] = this.plateName;
    data['like_count'] = this.likeCount;
    data['reply_count'] = this.replyCount;
    return data;
  }
}
