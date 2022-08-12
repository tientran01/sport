import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_event.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_state.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteLoading()) {
    on<AddVideoToFavoriteEvent>(_onAddVideoToFavorite);
    on<GetListFavoritesEvent>(_onGetListFavorites);
  }

  List<Video?> listVideo = <Video>[];

  Future<void> _onAddVideoToFavorite(
    AddVideoToFavoriteEvent event,
    Emitter<void> emitter,
  ) async {
    if (listVideo.contains(event.video) == true) {
      Loading.showError(AppStrings.isExistFavorite);
    } else {
      Loading.showSuccess(AppStrings.addFavorite);
      listVideo.add(event.video);
      emitter(FavoriteLoader(isFavorite: event.isFavorite));
    }
  }

  Future<void> _onGetListFavorites(
    GetListFavoritesEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(FavoriteLoader(videos: listVideo.toSet()));
  }

  static FavoriteBloc of(BuildContext context) =>
      BlocProvider.of<FavoriteBloc>(context);
}
