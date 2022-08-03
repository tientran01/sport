import 'package:equatable/equatable.dart';
import 'package:sport_app/model/your_article.dart';

abstract class YourArticleEvent extends Equatable {
  const YourArticleEvent();
  @override
  List<Object?> get props => [];
}

class GetYourArticleEvent extends YourArticleEvent {
  final YourArticle? yourArticle;
  const GetYourArticleEvent({this.yourArticle});
  @override
  List<Object?> get props => [yourArticle];
}
class CreateNewYourArticleEvent extends YourArticleEvent {
  final YourArticle? yourArticle;
  const CreateNewYourArticleEvent({this.yourArticle});
  @override
  List<Object?> get props => [yourArticle];
}
