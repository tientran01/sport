import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoading()) {
    on<SearchArticleEvent>(_onSearchArticle);
  }

  Future<void> _onSearchArticle(
    SearchArticleEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = (await ApiClient.api.getTopHeadlines());
    if (news != null) {
      Loading.dismiss();
      emitter(SearchLoader(
        results: news.articles
            ?.expand(
              (element) => [
                if ((element.title?.toLowerCase() ?? '')
                    .contains(event.searchText?.toLowerCase() ?? ''))
                  element,
              ],
            )
            .toList(),
      ));
    } else {
      emitter(const SearchLoader(results: null));
    }
  }

  static SearchBloc of(BuildContext context) =>
      BlocProvider.of<SearchBloc>(context);
}
