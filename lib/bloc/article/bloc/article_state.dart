import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/model/your_article.dart';

class ArticleState extends Equatable {
  final List<Article>? articles;
  final Article? article;
  final String? nameCategory;
  final YourArticle? yourArticle;
  const ArticleState({
    this.articles,
    this.article,
    this.nameCategory,
    this.yourArticle,
  });
  const ArticleState.initState() : this();
  ArticleState copyWith({
    List<Article>? articles,
    Article? article,
    String? nameCategory,
    YourArticle? yourArticle,
  }) {
    return ArticleState(
      articles: articles,
      article: article,
      nameCategory: nameCategory,
      yourArticle: yourArticle,
    );
  }

  @override
  List<Object?> get props => [articles, article, nameCategory, yourArticle];
}

class FailureArticle extends ArticleState {
  final String? error;
  const FailureArticle({this.error});
  @override
  List<Object?> get props => [error];
}

class LoadingArticle extends ArticleState {}
