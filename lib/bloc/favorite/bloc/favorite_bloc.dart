import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_event.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_state.dart';
import 'package:sport_app/helper/favorite_box.dart';
import 'package:sport_app/model/video.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState.initState()) {
    on<AddVideoToFavoriteEvent>(_onAddVideoToFavorite);
    on<GetFavoritesEvent>(_onGetFavorite);
  }

  Future<void> _onAddVideoToFavorite(
    AddVideoToFavoriteEvent event,
    Emitter<void> emitter,
  ) async {
    FavoriteBox.shared.addVideoToFavorite(event.video);
  }

  Future<void> _onGetFavorite(
    GetFavoritesEvent event,
    Emitter<void> emitter,
  ) async {
    List<Video?>? listVideo = FavoriteBox.shared.getListFavorite();
    emitter(state.copyWith(videos: listVideo));
  }

  static FavoriteBloc of(BuildContext context) =>
      BlocProvider.of<FavoriteBloc>(context);
}
