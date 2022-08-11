class YourArticle {
  String? id;
  String? title;
  String? author;
  String? publishedAt;
  String? description;
  String? urlToImage;

  YourArticle({
    this.id,
    this.title,
    this.author,
    this.publishedAt,
    this.description,
    this.urlToImage,
  });

  YourArticle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    publishedAt = json['publishedAt'];
    description = json['description'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'publishedAt': publishedAt,
        'description': description,
        'urlToImage': urlToImage,
      };
}
