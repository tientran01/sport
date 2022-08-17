import 'package:equatable/equatable.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/model/article.dart';

class AppleNewsState extends Equatable {
  final NewsStatus status;
  final List<Article>? articles;
  const AppleNewsState({
    this.articles,
    this.status = NewsStatus.initial,
  });
  AppleNewsState copyWith({
    NewsStatus? status,
    List<Article>? articles, 
  }) {
    return AppleNewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
    );
  }
  @override
  List<Object?> get props => [status, articles];
}
