import 'package:equatable/equatable.dart';
import 'package:sport_app/model/your_article.dart';

class YourArticleState extends Equatable {
  final String? title;
  final String? description;
  final List<YourArticle?>? yourArticles;
  const YourArticleState({this.title, this.description, this.yourArticles});
  const YourArticleState.initState() : this();

  YourArticleState copyWith({
    String? title,
    String? description,
    List<YourArticle?>? yourArticles,
  }) {
    return YourArticleState(
      title: title,
      description: description,
      yourArticles: yourArticles,
    );
  }

  @override
  List<Object?> get props => [title, description, yourArticles];
}
