import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class HotNewsState extends Equatable {
  const HotNewsState();
  @override
  List<Object?> get props => [];
}

class HotNewsLoading extends HotNewsState {}

class HotNewsLoader extends HotNewsState {
  final List<Article>? articles;
  const HotNewsLoader({this.articles});
  @override
  List<Object?> get props => [articles];
}

class HotNewsError extends HotNewsState {}