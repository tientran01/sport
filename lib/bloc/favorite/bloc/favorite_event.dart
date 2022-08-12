import 'package:equatable/equatable.dart';
import 'package:sport_app/model/video.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object?> get props => [];
}

class AddVideoToFavoriteEvent extends FavoriteEvent {
  final Video? video;
  final Set<Video>? videos;
  final bool? isFavorite;
  const AddVideoToFavoriteEvent({
    this.video,
    this.videos,
    this.isFavorite,
  });
  @override
  List<Object?> get props => [video, videos, isFavorite];
}

class GetListFavoritesEvent extends FavoriteEvent {}

class ToggleInFavoritesEvent extends FavoriteEvent {
  final Video? video;
  final bool? isFavorite;
  const ToggleInFavoritesEvent({this.video, this.isFavorite});
  @override
  List<Object?> get props => [video, isFavorite];
}

class RemoveAllEvent extends FavoriteEvent {}
