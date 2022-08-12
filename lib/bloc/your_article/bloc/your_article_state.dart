import 'package:equatable/equatable.dart';
import 'package:sport_app/model/your_article.dart';

abstract class YourArticleState extends Equatable {
  final String? title;
  final String? description;
  const YourArticleState({this.title, this.description});
  @override
  List<Object?> get props => [title, description];
}

class YourArticleLoading extends YourArticleState {}

class YourArticleLoader extends YourArticleState {
  final String? title;
  final String? description;
  final List<YourArticle>? yourArticles;
  final String? id;
  const YourArticleLoader({
    this.title,
    this.description,
    this.yourArticles,
    this.id,
  });
  @override
  List<Object?> get props => [title, description, yourArticles, id];
}

class YourArticleError extends YourArticleState {}