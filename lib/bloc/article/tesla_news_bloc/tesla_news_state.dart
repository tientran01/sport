import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class TeslaNewsState extends Equatable {
  const TeslaNewsState();
  @override
  List<Object?> get props => [];
}

class TeslaNewsLoading extends TeslaNewsState {}

class TeslaNewsLoader extends TeslaNewsState {
  final List<Article>? articles;
  const TeslaNewsLoader({this.articles});
  @override
  List<Object?> get props => [articles];
}

class TeslaNewsError extends TeslaNewsState {}
