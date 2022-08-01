import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(const ArticleState.initState()) {
    on<GetAllArticleEvent>(_onGetAllArticle);
    on<GetTopArticleEvent>(_onGetTopArticle);
    on<GetArticleFromTextFieldEvent>(_onGetArticleFromTextField);
    on<CreateNewArticleEvent>(_onCreateNewArticle);
  }

  Future<void> _onGetAllArticle(
    GetAllArticleEvent event,
    Emitter<void> emitter,
  ) async {
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

  static ArticleBloc of(BuildContext context) =>
      BlocProvider.of<ArticleBloc>(context);
}
