import 'package:equatable/equatable.dart';
import 'package:sport_app/model/article.dart';

class SearchState extends Equatable {
  final List<Article>? results;
  const SearchState({this.results});
  const SearchState.initState() : this();
  SearchState copyWith({
    List<Article>? results,
  }) {
    return SearchState(
      results: results,
    );
  }

  @override
  List<Object?> get props => [results];
}
