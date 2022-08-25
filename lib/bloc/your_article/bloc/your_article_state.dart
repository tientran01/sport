import 'package:equatable/equatable.dart';
import 'package:sport_app/model/your_article.dart';

abstract class YourArticleState extends Equatable {
  final YourArticle? yourArticle;
  const YourArticleState({this.yourArticle});
  @override
  List<Object?> get props => [yourArticle];
}

class YourArticleLoading extends YourArticleState {}

class YourArticleLoader extends YourArticleState {
  final List<YourArticle>? yourArticles;
  final int? id;
  final DateTime? selectedDate;
  const YourArticleLoader({
    this.yourArticles,
    this.id,
    super.yourArticle,
    this.selectedDate,
  });
  @override
  List<Object?> get props => [yourArticles, id, yourArticle, selectedDate];
}

class YourArticleError extends YourArticleState {}
