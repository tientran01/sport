import 'package:equatable/equatable.dart';
import 'package:sport_app/model/your_article.dart';

abstract class YourArticleEvent extends Equatable {
  const YourArticleEvent();
  @override
  List<Object?> get props => [];
}

class CreateNewYourArticleEvent extends YourArticleEvent {
  final YourArticle yourArticle;
  const CreateNewYourArticleEvent({required this.yourArticle});
  @override
  List<Object?> get props => [yourArticle];
}

class GetAllYourArticleEvent extends YourArticleEvent {}

class DeleteYourArticleEvent extends YourArticleEvent {
  final int? id;
  const DeleteYourArticleEvent({this.id});
  @override
  List<Object?> get props => [id];
}

class UpdateYourArticleEvent extends YourArticleEvent {
  final YourArticle yourArticle;
  const UpdateYourArticleEvent({required this.yourArticle});
   @override
  List<Object?> get props => [yourArticle];
}

class SortYourArticleByDateEvent extends YourArticleEvent {}

class SortYourArticleByAlphabetEvent extends YourArticleEvent {}