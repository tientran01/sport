class YourArticle {
  String? title;
  String? author;
  String? publishedAt;
  String? description;
  String? urlToImage;

  YourArticle({
    this.title,
    this.author,
    this.publishedAt,
    this.description,
    this.urlToImage,
  });

  YourArticle.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    publishedAt = json['publishedAt'];
    description = json['description'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'publishedAt': publishedAt,
        'description': description,
        'urlToImage': urlToImage,
      };
}
