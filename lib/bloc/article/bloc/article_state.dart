import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();
  @override
  List<Object?> get props => [];
}

class ArticleLoading extends ArticleState {}

class ArticleError extends ArticleState {
  final String? error;
  const ArticleError({this.error});
  @override
  List<Object?> get props => [error];
}

class ArticleLoader extends ArticleState {
  final List<Article>? articles;
  final Article? article;
  final String? nameCategory;
  const ArticleLoader({this.articles, this.article, this.nameCategory});

  @override
  List<Object?> get props => [articles, article, nameCategory];
}
