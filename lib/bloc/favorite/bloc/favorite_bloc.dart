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
  }

  Future<void> _onAddVideoToFavorite(
    AddVideoToFavoriteEvent event,
    Emitter<void> emitter,
  ) async {
    final int index = (state.videos ?? [])
        .indexWhere((element) => element?.id == event.video?.id);
    if (index == -1) {
      final favorites = List<Video?>.from(state.videos ?? []);
      favorites.add(event.video);
      event.video?.isFavorite = true;
      Loading.showSuccess(AppStrings.addFavorite);
      emitter(FavoriteLoader(
        videos: favorites,
      ));
    } else {
      final favorites = List<Video?>.from(state.videos ?? []);
      Loading.showError(AppStrings.removeFavorite);
      favorites.removeAt(index);
      event.video?.isFavorite = false;
      emitter(FavoriteLoader(
        videos: favorites,
      ));
    }
  }


  static FavoriteBloc of(BuildContext context) =>
      BlocProvider.of<FavoriteBloc>(context);
}
