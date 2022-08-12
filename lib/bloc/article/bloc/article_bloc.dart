import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleLoading()) {
    on<GetTopHeadlinesEvent>(_onGetTopHeadlines);
    on<GetTopHeadlinesWithSourceEvent>(_onGetTopHeadlinesWithSource);
    on<GetCategoryNameEvent>(_onGetCategoryName);
    on<GetEverythingEvent>(_onGetEverything);
  }

  Future<void> _onGetTopHeadlines(
    GetTopHeadlinesEvent event,
    Emitter<ArticleState> emitter,
  ) async {
    try {
      News? news = (await ApiClient.api.getTopHeadlines());
      if (news != null) {
        emitter(ArticleLoader(articles: news.articles));
      }
    } catch (e) {
      emitter( ArticleError(error: e.toString()));
    }
  }

  Future<void> _onGetTopHeadlinesWithSource(
    GetTopHeadlinesWithSourceEvent event,
    Emitter<ArticleState> emitter,
  ) async {
    News? news = await ApiClient.api.getTopHeadlinesWithSource();
    if (news != null) {
      Loading.dismiss();
      emitter(ArticleLoader(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
      emitter(const ArticleLoader(articles: null));
    }
  }

  Future<void> _onGetCategoryName(
    GetCategoryNameEvent event,
    Emitter<ArticleState> emitter,
  ) async {
    emitter(
      ArticleLoader(
        nameCategory: event.nameCategory,
      ),
    );
  }

  Future<void> _onGetEverything(
    GetEverythingEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api.getEverything(
      endpoint: event.nameCategory ?? "",
    );
    if (news != null) {
      emitter(ArticleLoader(articles: news.articles));
      Loading.dismiss();
    } else {
      emitter(
        const ArticleError(
          error: AppStrings.error,
        ),
      );
    }
  }

  static ArticleBloc of(BuildContext context) =>
      BlocProvider.of<ArticleBloc>(context);
}
