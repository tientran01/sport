import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/hot_news/cubit/hot_news_state.dart';
import 'package:sport_app/dio/dio_client.dart';
import 'package:sport_app/model/news.dart';

class HotNewsCubit extends Cubit<HotNewsState> {
  HotNewsCubit() : super(const HotNewsState());
  Future<void> getHotNewsApi() async {
    
    News? news = await DioClient.shared.getTopHeadlinesWithSource();
    if (news?.articles?.isNotEmpty == true) {
      emit(
        state.copyWith(
          status: NewsStatus.success,
          articles: news?.articles,
        ),
      );
    } else {
      emit(state.copyWith(status: NewsStatus.error));
    }
  }

  static HotNewsCubit of(BuildContext context) =>
      BlocProvider.of<HotNewsCubit>(context);
}
