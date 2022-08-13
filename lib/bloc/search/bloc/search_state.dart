import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState {}

class SearchLoader extends SearchState {
  final List<Article>? results;
  const SearchLoader({this.results});
  @override
  List<Object?> get props => [results];
}

class SearchError extends SearchState {
  final String? error;
  const SearchError({this.error});
  @override
  List<Object?> get props => [error];
}
