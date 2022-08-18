import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_event.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_state.dart';
import 'package:sport_app/dio/dio_client.dart';
import 'package:sport_app/model/news.dart';

class MostInterestedNewsBloc
    extends Bloc<MostInterestedNewsEvent, MostInterestedNewsState> {
  MostInterestedNewsBloc() : super(MostInterestedNewsLoading()) {
    on<MostInterestedNewsApiEvent>(_onMostInterestedNewsApi);
  }
  Future<void> _onMostInterestedNewsApi(
    MostInterestedNewsApiEvent event,
    Emitter<void> emitter,
  ) async {
    News? news = await DioClient.shared.getTopHeadlines();
    if (news != null) {
      emitter(MostInterestedNewsLoader(articles: news.articles));
    } else {
      emitter(const MostInterestedNewsLoader(articles: null));
    }
  }

  static MostInterestedNewsBloc of(BuildContext context) =>
      BlocProvider.of<MostInterestedNewsBloc>(context);
}
