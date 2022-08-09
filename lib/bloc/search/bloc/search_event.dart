import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchArticleEvent extends SearchEvent {
  final List<Article?>? results;
  final String? searchText;
  const SearchArticleEvent({this.results, this.searchText});
  @override
  List<Object?> get props => [results, searchText];
}
