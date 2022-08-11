import 'package:equatable/equatable.dart';
import 'package:sport_app/model/your_article.dart';

class YourArticleState extends Equatable {
  final String? title;
  final String? description;
  final List<YourArticle>? yourArticles;
  final String? id;
  const YourArticleState({
    this.title,
    this.description,
    this.yourArticles,
    this.id,
  });
  const YourArticleState.initState() : this();

  YourArticleState copyWith({
    String? title,
    String? description,
    List<YourArticle>? yourArticles,
    String? id,
  }) {
    return YourArticleState(
      title: title,
      description: description,
      yourArticles: yourArticles,
      id: id,
    );
  }

  @override
  List<Object?> get props => [title, description, yourArticles, id];
}
