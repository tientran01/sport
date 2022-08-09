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

class CreateNewArticleEvent extends YourArticleEvent {}

