import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleBloc extends Bloc<YourArticleEvent, YourArticleState> {
  YourArticleBloc() : super(const YourArticleState.initState()) {
    on<GetArticleFromTextFieldEvent>(_onGetArticleFromTextField);
    on<CreateNewYourArticleEvent>(_onCreateNewYourArticle);
    on<GetYourArticlesEvent>(_onGetYourArticles);
    on<DeleteYourArticleEvent>(_onDeleteYourArticle);
  }

  Future<void> _onGetArticleFromTextField(
    GetArticleFromTextFieldEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(
      title: event.title ?? state.title,
      description: event.description ?? state.description,
    ));
  }

  Future<void> _onCreateNewYourArticle(
    CreateNewYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    YourArticle yourArticle = YourArticle(
      title: state.title,
      description: state.description,
    );
    Loading.show();
    FirebaseHelper.shared.createNewArticle(yourArticle);
    Loading.dismiss();
    NavigationService.navigatorKey.currentState?.pop();
    getIt.get<YourArticleBloc>().add(GetYourArticlesEvent());
  }

  Future<void> _onGetYourArticles(
    GetYourArticlesEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    List<YourArticle> yourArticles =
        await FirebaseHelper.shared.getYourArticles();
    Loading.dismiss();
    emitter(state.copyWith(yourArticles: yourArticles));
  }

  Future<void> _onDeleteYourArticle(
      DeleteYourArticleEvent event, Emitter<void> emitter) async {
    FirebaseHelper.shared.deleteYourArticle(event.id ?? state.id);
    getIt.get<YourArticleBloc>().add(GetYourArticlesEvent());
  }

  static YourArticleBloc of(BuildContext context) =>
      BlocProvider.of<YourArticleBloc>(context);
}
