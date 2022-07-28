

import 'package:sport_app/model/article.dart';
import 'package:sport_app/model/pagination.dart';

class News {
  Pagination? pagination;
  List<Article>? articles;

  News({this.pagination, this.articles});

  News.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      articles = <Article>[];
      json['data'].forEach((article) {
        articles?.add(Article.fromJson(article));
      });
    }
  }
}