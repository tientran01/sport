class YourArticle {
  int? id;
  String? title;
  String? author;
  String? publishedAt;
  String? describe;
  String? urlToImage;

  YourArticle({
    this.id,
    this.title,
    this.author,
    this.publishedAt,
    this.describe,
    this.urlToImage,
  });

  YourArticle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    publishedAt = json['publishedAt'];
    describe = json['describe'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'publishedAt': publishedAt,
        'describe': describe,
        'urlToImage': urlToImage,
      };
}
