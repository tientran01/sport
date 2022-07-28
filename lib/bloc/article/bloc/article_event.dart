import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
  @override
  List<Object?> get props => [];
}

class GetArticleEvent extends ArticleEvent {
  final Article? article;
  const GetArticleEvent({this.article});
  @override
  List<Object?> get props => [article];
}
