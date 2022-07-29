import 'package:sport_app/model/article.dart';
import 'package:sport_app/model/pagination.dart';

class News {
  Meta? meta;
  List<Article>? articles;

  News({
    this.meta,
    this.articles,
  });

  News.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      articles = <Article>[];
      json['data'].forEach(
        (v) {
          articles!.add(Article.fromJson(v));
        },
      );
    }
  }
}
