class Data {
  int? userId;
  int? id;
  String? title;
  String? body;

  Data({this.userId, this.id, this.title, this.body});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}

class GetData {
  List<Data>? datas;
  GetData({this.datas});
  GetData.fromJson(List<dynamic> json) {
    datas = json.map((e) => Data.fromJson(e)).toList();
  }
}
