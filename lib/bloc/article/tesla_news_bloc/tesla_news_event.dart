import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class TeslaNewsEvent extends Equatable {
  const TeslaNewsEvent();
  @override
  List<Object?> get props => [];
}

class TeslaNewsApiEvent extends TeslaNewsEvent {
  final List<Article>? articles;
  const TeslaNewsApiEvent({this.articles});
  @override
  List<Object?> get props => [articles];
}
