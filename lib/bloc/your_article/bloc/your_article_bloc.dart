import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleBloc extends Bloc<YourArticleEvent, YourArticleState> {
  YourArticleBloc() : super(const YourArticleState.initState()) {
    on<GetArticleFromTextFieldEvent>(_onGetArticleFromTextField);
    on<CreateNewArticleEvent>(_onCreateNewArticle);
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

  Future<void> _onCreateNewArticle(
    CreateNewArticleEvent event,
    Emitter<void> emitter,
  ) async {
    YourArticle yourArticle = YourArticle(
      title: state.title,
      description: state.description,
    );
    FirebaseHelper.shared.createNewArticle(yourArticle);
    NavigationService.navigatorKey.currentState?.pop();
  }

  static YourArticleBloc of(BuildContext context) =>
      BlocProvider.of<YourArticleBloc>(context);
}
