import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_event.dart';
import 'package:sport_app/bloc/search/bloc/search_state.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';
import '../../../resource/app_strings.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState.initState()) {
    on<SearchArticleEvent>(_onSearchArticle);
  }

  Future<void> _onSearchArticle(
    SearchArticleEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    News? news = (await ApiClient.api.getTopHeadlines());
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(
        results: news.articles
          ?.expand(
            (element) => [
              if ((element.title?.toLowerCase() ?? '').contains(event.searchText?.toLowerCase() ?? ''))
                element
            ],
          )
          .toList(),
      ));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  static SearchBloc of(BuildContext context) =>
      BlocProvider.of<SearchBloc>(context);
}
