import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class MostInterestedNewsState extends Equatable {
  const MostInterestedNewsState();
  @override
  List<Object?> get props => [];
}

class MostInterestedNewsLoading extends MostInterestedNewsState {}

class MostInterestedNewsLoader extends MostInterestedNewsState {
  final List<Article>? articles;
  const MostInterestedNewsLoader({this.articles});
  @override
  List<Object?> get props => [articles];
}

class MostInterestedNewsError extends MostInterestedNewsState {}
