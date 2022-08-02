import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(const ArticleState.initState()) {
    on<GetTopHeadlinesEvent>(_onGetTopHeadlines);
    on<GetArticleFromTextFieldEvent>(_onGetArticleFromTextField);
    on<CreateNewArticleEvent>(_onCreateNewArticle);
    on<GetTopHeadlinesWithSourceEvent>(_onGetTopHeadlinesWithSource);
    on<GetAppleEvent>(_onGetApple);
    on<GetBitcoinEvent>(_onGetBitcoin);
    on<GetTestaEvent>(_onGetTesla);
    on<GetCategoryNameEvent>(_onGetCategoryName);
  }

  Future<void> _onGetTopHeadlines(
    GetTopHeadlinesEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api.getTopHeadlines();
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetTopHeadlinesWithSource(
    GetTopHeadlinesWithSourceEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api.getTopHeadlinesWithSource();
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetArticleFromTextField(
    GetArticleFromTextFieldEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(
      title: event.title ?? state.title,
      description: event.description ?? state.description,
      imageUrl: event.imageUrl ?? state.imageUrl,
    ));
  }

  Future<void> _onCreateNewArticle(
    CreateNewArticleEvent event,
    Emitter<void> emitter,
  ) async {
    FirebaseHelper.shared.createNewArticle(
      title: state.title,
      description: state.description,
    );
    NavigationService.navigatorKey.currentState?.pop();
  }

  Future<void> _onGetApple(
    GetAppleEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api.getApple();
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetBitcoin(
    GetBitcoinEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api.getBitcoin();
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetTesla(
    GetTestaEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api.getTesla();
    if (news != null) {
      Loading.dismiss();
      emitter(state.copyWith(articles: news.articles));
    } else {
      Loading.showError(AppStrings.error);
    }
  }

  Future<void> _onGetCategoryName(
    GetCategoryNameEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(nameCategory: event.nameCategory));
    getIt.get<ArticleBloc>().add(GetAppleEvent());
  }

  static ArticleBloc of(BuildContext context) =>
      BlocProvider.of<ArticleBloc>(context);
}
