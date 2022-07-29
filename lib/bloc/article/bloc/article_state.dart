import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

class ArticleState extends Equatable {
  final List<Article>? articles;
  const ArticleState({this.articles});
  const ArticleState.initState() : this();
  ArticleState copyWith({
    List<Article>? articles,
  }) {
    return ArticleState(
      articles: articles
    );
  }

  @override
  List<Object?> get props => [articles];
}
