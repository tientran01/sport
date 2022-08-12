import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class AppleNewsState extends Equatable {
  const AppleNewsState();
  @override
  List<Object?> get props => [];
}

class AppleNewsLoading extends AppleNewsState {}

class AppleNewsLoader extends AppleNewsState {
  final List<Article>? articles;
  const AppleNewsLoader({this.articles});
  @override
  List<Object?> get props => [articles];
}

class AppleNewsError extends AppleNewsState {}
