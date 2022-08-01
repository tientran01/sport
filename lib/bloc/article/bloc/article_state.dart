import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

class ArticleState extends Equatable {
  final List<Article>? articles;
  final String? title;
  final String? description;
  final String? imageUrl;
  const ArticleState(
      {this.articles, this.title, this.description, this.imageUrl});
  const ArticleState.initState() : this();
  ArticleState copyWith({
    List<Article>? articles,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return ArticleState(
      articles: articles,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }

  @override
  List<Object?> get props => [articles, title, description, imageUrl];
}
