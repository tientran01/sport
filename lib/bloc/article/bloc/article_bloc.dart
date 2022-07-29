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
    on<GetAllArticleEvent>(_onGetAllArticle);
    on<GetTopArticleEvent>(_onGetTopArticle);
  }

  Future<void> _onGetAllArticle(
    GetAllArticleEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    News? news = await ApiClient.api.getAllNews();
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetTopArticle(
    GetTopArticleEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    News? news = await ApiClient.api.getTopNews();
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  static ArticleBloc of(BuildContext context) =>
      BlocProvider.of<ArticleBloc>(context);
}
