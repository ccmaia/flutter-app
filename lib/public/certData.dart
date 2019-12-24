class certData {
  int result;
  List<Data> data;

  certData({this.result, this.data});

  certData.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int userId;
  String name;
  int sex;
  String idCard;
  int phone;
  int groups;
  int examId;
  Exam exam;
  int courseId;
  Course course;
  String trainAddress;
  String score;
  String certCode;
  String certScode;
  String status;
  int createTime;
  int updateTime;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.sex,
        this.idCard,
        this.phone,
        this.groups,
        this.examId,
        this.exam,
        this.courseId,
        this.course,
        this.trainAddress,
        this.score,
        this.certCode,
        this.certScode,
        this.status,
        this.createTime,
        this.updateTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    sex = json['sex'];
    idCard = json['id_card'];
    phone = json['phone'];
    groups = json['groups'];
    examId = json['exam_id'];
    exam = json['exam'] != null ? new Exam.fromJson(json['exam']) : null;
    courseId = json['course_id'];
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
    trainAddress = json['train_address'];
    score = json['score'];
    certCode = json['cert_code'];
    certScode = json['cert_scode'];
    status = json['status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['sex'] = this.sex;
    data['id_card'] = this.idCard;
    data['phone'] = this.phone;
    data['groups'] = this.groups;
    data['exam_id'] = this.examId;
    if (this.exam != null) {
      data['exam'] = this.exam.toJson();
    }
    data['course_id'] = this.courseId;
    if (this.course != null) {
      data['course'] = this.course.toJson();
    }
    data['train_address'] = this.trainAddress;
    data['score'] = this.score;
    data['cert_code'] = this.certCode;
    data['cert_scode'] = this.certScode;
    data['status'] = this.status;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    return data;
  }
}

class Exam {
  int id;
  int addressId;
  String addressName;
  int examTime;
  int createTime;
  int updateTime;
  int status;
  Null queryStartTime;
  Null queryEndTime;

  Exam(
      {this.id,
        this.addressId,
        this.addressName,
        this.examTime,
        this.createTime,
        this.updateTime,
        this.status,
        this.queryStartTime,
        this.queryEndTime});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressId = json['address_id'];
    addressName = json['address_name'];
    examTime = json['exam_time'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    status = json['status'];
    queryStartTime = json['query_start_time'];
    queryEndTime = json['query_end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_id'] = this.addressId;
    data['address_name'] = this.addressName;
    data['exam_time'] = this.examTime;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['status'] = this.status;
    data['query_start_time'] = this.queryStartTime;
    data['query_end_time'] = this.queryEndTime;
    return data;
  }
}

class Course {
  int id;
  String name;
  String groups;

  Course({this.id, this.name, this.groups});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    groups = json['groups'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['groups'] = this.groups;
    return data;
  }
}
