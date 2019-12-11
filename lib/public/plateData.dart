

class Data {
  int id;
  String name;

  Data({this.id, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class plateData {
  List data;
  plateData(this.data);
  factory plateData.formJson(List json){
    return plateData(
        json.map((i)=>Data.fromJson((i))).toList()
    );
  }

}