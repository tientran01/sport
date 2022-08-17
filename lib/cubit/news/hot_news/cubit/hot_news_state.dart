import 'package:equatable/equatable.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/model/article.dart';

class HotNewsState extends Equatable {
  final NewsStatus status;
  final List<Article>? articles;
  const HotNewsState({
    this.articles,
    this.status = NewsStatus.initial,
  });
  HotNewsState copyWith({
    NewsStatus? status,
    List<Article>? articles,
  }) {
    return HotNewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [status, articles];
}
