import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

class ArticleState extends Equatable {
  final List<Article>? articles;
  final Article? article;
  final String? nameCategory;
  const ArticleState({
    this.articles,
    this.article,
    this.nameCategory,
  });
  const ArticleState.initState() : this();
  ArticleState copyWith({
    List<Article>? articles,
    Article? article,
    String? nameCategory,
  }) {
    return ArticleState(
      articles: articles,
      article: article,
      nameCategory: nameCategory,
    );
  }

  @override
  List<Object?> get props => [articles, article, nameCategory];
}
