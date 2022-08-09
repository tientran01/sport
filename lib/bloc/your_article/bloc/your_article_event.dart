import 'package:equatable/equatable.dart';

abstract class YourArticleEvent extends Equatable {
  const YourArticleEvent();
  @override
  List<Object?> get props => [];
}

class GetArticleFromTextFieldEvent extends YourArticleEvent {
  final String? title;
  final String? description;
  const GetArticleFromTextFieldEvent({this.title, this.description});
  @override
  List<Object?> get props => [title, description];
}

class CreateNewYourArticleEvent extends YourArticleEvent {}

class GetYourArticlesEvent extends YourArticleEvent {}

class DeleteYourArticleEvent extends YourArticleEvent {
  final String? id;
  const DeleteYourArticleEvent({this.id});
  @override
  List<Object?> get props => [id];
}
