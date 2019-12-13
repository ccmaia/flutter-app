class threamDetail {
  int result;
  Data data;

  threamDetail({this.result, this.data});

  threamDetail.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String title;
  String describe;
  int groups;
  int plate;
  String tag;
  List<String> image;
  int date;
  int like;
  int likeCount;
  int replyCount;
  int userId;
  String userName;
  String userHeadImg;
  List<ThreadReplyResp> threadReplyResp;

  Data(
      {this.id,
        this.title,
        this.describe,
        this.groups,
        this.plate,
        this.tag,
        this.image,
        this.date,
        this.like,
        this.likeCount,
        this.replyCount,
        this.userId,
        this.userName,
        this.userHeadImg,
        this.threadReplyResp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    describe = json['describe'];
    groups = json['groups'];
    plate = json['plate'];
    tag = json['tag'];
    image = json['image'].cast<String>();
    date = json['date'];
    like = json['like'];
    likeCount = json['like_count'];
    replyCount = json['reply_count'];
    userId = json['user_id'];
    userName = json['user_name'];
    userHeadImg = json['user_head_img'];
    if (json['thread_reply_resp'] != null) {
      threadReplyResp = new List<ThreadReplyResp>();
      json['thread_reply_resp'].forEach((v) {
        threadReplyResp.add(new ThreadReplyResp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['describe'] = this.describe;
    data['groups'] = this.groups;
    data['plate'] = this.plate;
    data['tag'] = this.tag;
    data['image'] = this.image;
    data['date'] = this.date;
    data['like'] = this.like;
    data['like_count'] = this.likeCount;
    data['reply_count'] = this.replyCount;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_head_img'] = this.userHeadImg;
    if (this.threadReplyResp != null) {
      data['thread_reply_resp'] =
          this.threadReplyResp.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThreadReplyResp {
  int id;
  int userId;
  String userName;
  String userHeadImg;
  int date;
  int like;
  int likeCount;
  String describe;

  ThreadReplyResp(
      {this.id,
        this.userId,
        this.userName,
        this.userHeadImg,
        this.date,
        this.like,
        this.likeCount,
        this.describe});

  ThreadReplyResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userHeadImg = json['user_head_img'];
    date = json['date'];
    like = json['like'];
    likeCount = json['like_count'];
    describe = json['describe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_head_img'] = this.userHeadImg;
    data['date'] = this.date;
    data['like'] = this.like;
    data['like_count'] = this.likeCount;
    data['describe'] = this.describe;
    return data;
  }
}
