import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/your_article.dart';

import '../../../router/navigation_service.dart';

class YourArticleBloc extends Bloc<YourArticleEvent, YourArticleState> {
  YourArticleBloc() : super(const YourArticleState.initState()) {
    on<GetYourArticleEvent>(_onGetYourArticle);
    on<CreateNewYourArticleEvent>(_onCreateNewYourArticle);
  }

  Future<void> _onGetYourArticle(
    GetYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    YourArticle? yourArticle = await FirebaseHelper.shared.getYourArticle();
    Loading.dismiss();
    emitter(state.copyWith(yourArticle: yourArticle));
  }

  Future<void> _onCreateNewYourArticle(
    CreateNewYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    FirebaseHelper.shared.createYourArticle(yourArticle: event.yourArticle);
    Loading.dismiss();
    NavigationService.navigatorKey.currentState?.pop();
  }

  static YourArticleBloc of(BuildContext context) =>
      BlocProvider.of<YourArticleBloc>(context);
}
