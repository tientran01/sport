import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/apple_news_bloc/apple_news_event.dart';
import 'package:sport_app/bloc/article/apple_news_bloc/apple_news_state.dart';
import 'package:sport_app/dio/end_point.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';

class AppleNewsBloc extends Bloc<AppleNewsEvent, AppleNewsState> {
  AppleNewsBloc() : super(AppleNewsLoading()) {
    on<AppleNewsApiEvent>(_onAppleNewsApi);
  }

  Future<void> _onAppleNewsApi(
    AppleNewsApiEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await ApiClient.api
        .getEverything(endpoint: EndPoint.appleParamValue);
    if (news != null) {
      emitter(
        AppleNewsLoader(articles: news.articles),
      );
    } else {
      emitter(
        const AppleNewsLoader(articles: null),
      );
    }
  }

  static AppleNewsBloc of(BuildContext context) =>
      BlocProvider.of<AppleNewsBloc>(context);
}
