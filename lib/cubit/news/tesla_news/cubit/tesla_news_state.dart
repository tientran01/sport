import 'package:equatable/equatable.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/model/article.dart';

class TeslaNewsState extends Equatable {
  final NewsStatus status;
  final List<Article>? articles;
  const TeslaNewsState({
    this.articles,
    this.status = NewsStatus.loading
  });
  TeslaNewsState copyWith({
    NewsStatus? status,
    List<Article>? articles,
  }) {
    return TeslaNewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props => [status, articles];
}
