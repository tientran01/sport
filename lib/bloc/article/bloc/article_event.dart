import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
  @override
  List<Object?> get props => [];
}

class GetAllArticleEvent extends ArticleEvent {
  final Article? article;
  const GetAllArticleEvent({this.article});
  @override
  List<Object?> get props => [article];
}

class GetTopArticleEvent extends ArticleEvent {
  final Article? article;
  const GetTopArticleEvent({this.article});
  @override
  List<Object?> get props => [article];
}
