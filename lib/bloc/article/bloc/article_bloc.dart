import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(const ArticleState.initState()) {
    on<GetTopHeadlinesEvent>(_onGetTopHeadlines);
    on<GetTopHeadlinesWithSourceEvent>(_onGetTopHeadlinesWithSource);
    on<GetCategoryNameEvent>(_onGetCategoryName);
    on<GetEverythingEvent>(_onGetEverything);
  }

  Future<void> _onGetTopHeadlines(
    GetTopHeadlinesEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    News? news = await ApiClient.api.getTopHeadlines();
    if (news != null) {
      Loading.dismiss();
      emitter(
        state.copyWith(articles: news.articles),
      );
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetTopHeadlinesWithSource(
    GetTopHeadlinesWithSourceEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    News? news = await ApiClient.api.getTopHeadlinesWithSource();
    if (news != null) {
      Loading.dismiss();
      emitter(
        state.copyWith(articles: news.articles),
      );
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetCategoryName(
    GetCategoryNameEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(
      state.copyWith(
        nameCategory: event.nameCategory ?? state.nameCategory,
      ),
    );
  }

  Future<void> _onGetEverything(
    GetEverythingEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    News? news = await ApiClient.api.getEverything(
      endpoint: event.nameCategory ?? "",
    );
    if (news != null) {
      emitter(state.copyWith(articles: news.articles));
      Loading.dismiss();
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  static ArticleBloc of(BuildContext context) =>
      BlocProvider.of<ArticleBloc>(context);
}
