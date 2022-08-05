import 'package:sport_app/model/article.dart';

class News {
  String? status;
  int? totalResults;
  List<Article>? articles;

  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  News.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((article) {
        articles!.add(Article.fromJson(article));
      });
    }
  }
}
