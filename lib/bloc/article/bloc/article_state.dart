import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

class ArticleState extends Equatable {
  final Article? article;
  const ArticleState({this.article});
  const ArticleState.initState() : this();
  ArticleState copyWith({
    Article? article,
  }) {
    return ArticleState(
      article: article
    );
  }

  @override
  List<Object?> get props => [article];
}
