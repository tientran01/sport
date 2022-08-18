import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
import 'package:sport_app/dio/dio_client.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/news.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoading()) {
    on<SearchArticleEvent>(_onSearchArticle);
  }

  Future<void> _onSearchArticle(
    SearchArticleEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = (await DioClient.shared.getTopHeadlines());
    if (news != null) {
      Loading.dismiss();
      emitter(
        SearchLoader(
          results: news.articles
              ?.where((element) => (element.title?.toLowerCase() ?? "")
                  .contains((event.searchText?.toLowerCase()) ?? ""))
              .toList(),
        ),
      );
    } else {
      emitter(
        const SearchLoader(results: null),
      );
    }
  }

  static SearchBloc of(BuildContext context) =>
      BlocProvider.of<SearchBloc>(context);
}
