import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/most_interested_news/cubit/most_interested_news_state.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';

class MostInterestedNewsCubit extends Cubit<MostInterestedNewsState> {
  MostInterestedNewsCubit() : super(const MostInterestedNewsState());
  Future<void> getMostInterestedNewsApi() async {
    emit(state.copyWith(status: NewsStatus.loading));
    News? news = await ApiClient.api.getTopHeadlines();
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

  static MostInterestedNewsCubit of(BuildContext context) =>
      BlocProvider.of<MostInterestedNewsCubit>(context);
}
