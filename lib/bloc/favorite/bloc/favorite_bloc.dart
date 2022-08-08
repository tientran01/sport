import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_event.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_state.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState.initState()) {
    on<AddVideoToFavoriteEvent>(_onAddVideoToFavorite);
    on<GetFavoritesEvent>(_onGetFavorites);
  }

  List<Video?> listVideo = <Video>[];

  Future<void> _onAddVideoToFavorite(
    AddVideoToFavoriteEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(video: event.video));
    if (listVideo.contains(event.video ?? state.video) == true) {
      Loading.showError(AppStrings.isExistFavorite);
    } else {
      Loading.showSuccess(AppStrings.addFavorite);
      listVideo.add(state.video ?? event.video);
    }
  }

  Future<void> _onGetFavorites(
    GetFavoritesEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(videos: listVideo.toSet()));
  }
  static FavoriteBloc of(BuildContext context) =>
      BlocProvider.of<FavoriteBloc>(context);
}
