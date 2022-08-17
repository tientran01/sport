import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/tesla_news/cubit/tesla_news_state.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/api_client.dart';

class TeslaNewsCubit extends Cubit<TeslaNewsState> {
  TeslaNewsCubit() : super(const TeslaNewsState());
  Future<void> getTeslaNewsApi() async {
    News? news = await ApiClient.api.getEverything(
      endpoint: Application.teslaParamValue,
    );
    if (news != null) {
      return emit(
        state.copyWith(
          status: NewsStatus.success,
          articles: news.articles,
        ),
      );
    }
    return emit(state.copyWith(
      status: NewsStatus.error,
    ));
  }

  static TeslaNewsCubit of(BuildContext context) =>
      BlocProvider.of<TeslaNewsCubit>(context);
}
