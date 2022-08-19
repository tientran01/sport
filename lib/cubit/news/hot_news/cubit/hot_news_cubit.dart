import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/hot_news/cubit/hot_news_state.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';

class HotNewsCubit extends Cubit<HotNewsState> {
  HotNewsCubit() : super(const HotNewsState());
  Future<void> getHotNewsApi() async {
    News? news = await ApiClient.api.getTopHeadlinesWithSource();
    emit(
      state.copyWith(
        status: NewsStatus.success,
        articles: news?.articles,
      ),
    );
  }

  static HotNewsCubit of(BuildContext context) =>
      BlocProvider.of<HotNewsCubit>(context);
}
