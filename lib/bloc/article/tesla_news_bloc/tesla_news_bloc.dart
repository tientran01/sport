import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/bloc/article/tesla_news_bloc/tesla_news_event.dart';
import 'package:sport_app/bloc/article/tesla_news_bloc/tesla_news_state.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';

class TeslaNewsBloc extends Bloc<TeslaNewsEvent, TeslaNewsState> {
  TeslaNewsBloc() : super(TeslaNewsLoading()) {
    on<TeslaNewsApiEvent>(_onTeslaNewsApi);
  }

  Future<void> _onTeslaNewsApi(
    TeslaNewsApiEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api
        .getEverything(endpoint: Application.teslaParamValue);
    if (news != null) {
      emitter(TeslaNewsLoader(articles: news.articles));
    } else {
      emitter(const TeslaNewsLoader(articles: null));
    }
  }

  static TeslaNewsBloc of(BuildContext context) =>
      BlocProvider.of<TeslaNewsBloc>(context);
}
