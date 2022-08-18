import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_event.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_state.dart';
import 'package:sport_app/dio/dio_client.dart';
import 'package:sport_app/model/news.dart';

class HotNewsBloc extends Bloc<HotNewsEvent, HotNewsState> {
  HotNewsBloc() : super(HotNewsLoading()) {
    on<HotNewsLoadApiEvent>(_onHotNewsLoadApi);
  }

  Future<void> _onHotNewsLoadApi(
    HotNewsLoadApiEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await DioClient.shared.getTopHeadlinesWithSource();
    if (news != null) {
      emitter(HotNewsLoader(articles: news.articles));
    } else {
      emitter(const HotNewsLoader(articles: null));
    }
  }

  static HotNewsBloc of(BuildContext context) =>
      BlocProvider.of<HotNewsBloc>(context);
}
