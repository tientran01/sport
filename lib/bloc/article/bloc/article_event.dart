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

class GetArticleFromTextFieldEvent extends ArticleEvent {
  final String? title;
  final String? description;
  final String? imageUrl;
  const GetArticleFromTextFieldEvent(
      {this.title, this.imageUrl, this.description});
  @override
  List<Object?> get props => [title, imageUrl, description];
}

class GetAppleEvent extends ArticleEvent {}
class GetBitcoinEvent extends ArticleEvent {}
class GetTestaEvent extends ArticleEvent {}

class GetCategoryNameEvent extends ArticleEvent {
  final String? nameCategory;
  const GetCategoryNameEvent({this.nameCategory});
  @override
  List<Object?> get props => [nameCategory];
}

class CreateNewArticleEvent extends ArticleEvent {}
