import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/helper/sql_helper.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleBloc extends Bloc<YourArticleEvent, YourArticleState> {
  YourArticleBloc() : super(YourArticleLoading()) {
    on<CreateNewYourArticleEvent>(_onCreateNewYourArticle);
    on<GetAllYourArticleEvent>(_onGetAllYourArticle);
    on<DeleteYourArticleEvent>(_onDeleteYourArticle);
    on<UpdateYourArticleEvent>(_onUpdateYourArticle);
    on<SortYourArticleByDateEvent>(_onSortYourArticleByDate);
    on<SortYourArticleByAlphabetEvent>(_onSortYourArticleByAlphabet);
  }

  Future<void> _onCreateNewYourArticle(
    CreateNewYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    SQLHelper.shared.createArticle(event.yourArticle);
    NavigationService.navigatorKey.currentState?.pop();
    add(GetAllYourArticleEvent());
  }

  Future<void> _onGetAllYourArticle(
    GetAllYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    List<YourArticle> yourArticles = await SQLHelper.shared.getAllYourArticle();
    emitter(YourArticleLoader(yourArticles: yourArticles));
  }

  Future<void> _onDeleteYourArticle(
    DeleteYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    SQLHelper.shared.deleteYourArticle(event.id ?? 0);
    add(GetAllYourArticleEvent());
  }

  Future<void> _onUpdateYourArticle(
    UpdateYourArticleEvent event,
    Emitter<void> emitter,
  ) async {
    Loading.show();
    await SQLHelper.shared.updateYourArticle(event.yourArticle);
    add(GetAllYourArticleEvent());
    add(SortYourArticleByDateEvent());
    Loading.dismiss();
    NavigationService.navigatorKey.currentState?.pop();
  }

  Future<void> _onSortYourArticleByDate(
    SortYourArticleByDateEvent event,
    Emitter<void> emitter,
  ) async {
    List<YourArticle> yourArticles =
        await SQLHelper.shared.sortYourArticleByDate();
    emitter(YourArticleLoader(yourArticles: yourArticles));
    Loading.showSuccess(AppStrings.success);
  }

  Future<void> _onSortYourArticleByAlphabet(
    SortYourArticleByAlphabetEvent event,
    Emitter<void> emitter,
  ) async {
    List<YourArticle> yourArticles =
        await SQLHelper.shared.sortYourArticleByAlphabet();
    emitter(YourArticleLoader(yourArticles: yourArticles));
    Loading.showSuccess(AppStrings.success);
  }

  static YourArticleBloc of(BuildContext context) =>
      BlocProvider.of<YourArticleBloc>(context);
}
