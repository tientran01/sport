import 'package:equatable/equatable.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/model/article.dart';

class MostInterestedNewsState extends Equatable {
  final NewsStatus status;
  final List<Article>? articles;
  const MostInterestedNewsState({
    this.articles,
    this.status = NewsStatus.initial,
  });
  MostInterestedNewsState copyWith({
    NewsStatus? status,
    List<Article>? articles,
  }) {
    return MostInterestedNewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [status, articles];
}
