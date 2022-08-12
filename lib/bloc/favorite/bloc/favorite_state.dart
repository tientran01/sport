import 'package:equatable/equatable.dart';
import 'package:sport_app/model/video.dart';

class FavoriteState extends Equatable {
  final Video? video;
  final bool? isFavorite;
  const FavoriteState({
    this.video,
    this.isFavorite
  });
  @override
  List<Object?> get props => [video, isFavorite];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoader extends FavoriteState {
  final Set<Video?>? videos;
  const FavoriteLoader({
    this.videos,
    super.video,
    super.isFavorite,
  });

  @override
  List<Object?> get props => [videos, video, isFavorite];
}

class FavoriteError extends FavoriteState {}
