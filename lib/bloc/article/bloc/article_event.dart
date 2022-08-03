import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
  @override
  List<Object?> get props => [];
}

class GetTopHeadlinesEvent extends ArticleEvent {
  final Article? article;
  const GetTopHeadlinesEvent({this.article});
  @override
  List<Object?> get props => [article];
}

class GetTopHeadlinesWithSourceEvent extends ArticleEvent {
  final Article? article;
  const GetTopHeadlinesWithSourceEvent({this.article});
  @override
  List<Object?> get props => [article];
}


class GetEverythingEvent extends ArticleEvent {
  final String? nameCategory;
  const GetEverythingEvent({this.nameCategory});
  @override
  List<Object?> get props => [nameCategory];
}

class GetCategoryNameEvent extends ArticleEvent {
  final String? nameCategory;
  const GetCategoryNameEvent({this.nameCategory});
  @override
  List<Object?> get props => [nameCategory];
}
