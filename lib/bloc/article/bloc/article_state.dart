import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

class ArticleState extends Equatable {
  final List<Article>? articles;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? nameCategory;
  const ArticleState({
    this.articles,
    this.title,
    this.description,
    this.imageUrl,
    this.nameCategory,
  });
  const ArticleState.initState() : this();
  ArticleState copyWith({
    List<Article>? articles,
    String? title,
    String? description,
    String? imageUrl,
    String? nameCategory,
  }) {
    return ArticleState(
      articles: articles,
      title: title,
      description: description,
      imageUrl: imageUrl,
      nameCategory: nameCategory,
    );
  }

  @override
  List<Object?> get props => [articles, title, description, imageUrl];
}

class FailureArticle extends ArticleState {
  final String? error;
  const FailureArticle({this.error});
   @override
  List<Object?> get props => [error];
}

class LoadingArticle extends ArticleState {}
