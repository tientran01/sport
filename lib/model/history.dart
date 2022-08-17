class History {
  int? id;
  String? title;
  String? createdAt;
  History({this.id, this.title, this.createdAt});

  History.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'createdAt': createdAt,
      };
}
