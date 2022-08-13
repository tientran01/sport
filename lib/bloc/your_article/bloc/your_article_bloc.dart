import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleBloc extends Bloc<YourArticleEvent, YourArticleState> {
  YourArticleBloc() : super(YourArticleLoading()) {
    on<GetArticleFromTextFieldEvent>(_onGetArticleFromTextField);
    on<CreateNewYourArticleEvent>(_onCreateNewYourArticle);
    on<GetYourArticlesEvent>(_onGetYourArticles);
    on<DeleteYourArticleEvent>(_onDeleteYourArticle);
  }

  Future<void> _onGetArticleFromTextField(
    GetArticleFromTextFieldEvent event,
    Emitter<YourArticleState> emitter,
  ) async {
    emitter(
      YourArticleLoader(
        title: event.title ?? state.title,
        description: event.description ?? state.description,
      ),
    );
  }

  Future<void> _onCreateNewYourArticle(
    CreateNewYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    YourArticle yourArticle = YourArticle(
      title: state.title,
      description: state.description,
    );
    emitter(YourArticleLoading());
    FirebaseHelper.shared.createNewArticle(yourArticle);
    NavigationService.navigatorKey.currentState?.pop();
    add(GetYourArticlesEvent());
  }

  Future<void> _onGetYourArticles(
    GetYourArticlesEvent event,
    Emitter<void> emitter,
  ) async {
    List<YourArticle> yourArticles =
        await FirebaseHelper.shared.getYourArticles();
    if (yourArticles.isEmpty) {
      emitter(const YourArticleLoader(yourArticles: null));
    } else {
      emitter(YourArticleLoader(yourArticles: yourArticles));
    }
  }

  Future<void> _onDeleteYourArticle(
      DeleteYourArticleEvent event, Emitter<void> emitter) async {
    FirebaseHelper.shared.deleteYourArticle(event.id);
    add(GetYourArticlesEvent());
  }

  static YourArticleBloc of(BuildContext context) =>
      BlocProvider.of<YourArticleBloc>(context);
}
