import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/apple_news/cubit/apple_news_state.dart';
import 'package:sport_app/dio/dio_client.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/resource/resource.dart';

class AppleNewsCubit extends Cubit<AppleNewsState> {
  AppleNewsCubit() : super(const AppleNewsState());
  Future<void> getAppleNewsApi() async {
    News? news = await DioClient.shared.getEverything(
      endpoint: Application.appleParamValue,
    );
    if (news?.articles?.isNotEmpty == true) {
      emit(
        state.copyWith(
          status: NewsStatus.success,
          articles: news?.articles,
        ),
      );
    } else {
      emit(state.copyWith(
        status: NewsStatus.error,
      ));
    }
  }

  static AppleNewsCubit of(BuildContext context) =>
      BlocProvider.of<AppleNewsCubit>(context);
}
