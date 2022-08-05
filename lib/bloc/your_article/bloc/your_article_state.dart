import 'package:equatable/equatable.dart';
import 'package:sport_app/model/your_article.dart';

class YourArticleState extends Equatable {
  final YourArticle? yourArticle;
  const YourArticleState({this.yourArticle});
  const YourArticleState.initState() : this();

  YourArticleState copyWith({
    YourArticle? yourArticle,
  }) {
    return YourArticleState(
      yourArticle: yourArticle,
    );
  }

  @override
  List<Object?> get props => [yourArticle];
}
