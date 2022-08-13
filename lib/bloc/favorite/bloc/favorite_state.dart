import 'package:equatable/equatable.dart';
import 'package:sport_app/model/video.dart';

abstract class FavoriteState extends Equatable {
  final List<Video?>? videos;
  const FavoriteState({this.videos});

  @override
  List<Object?> get props => [videos];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoader extends FavoriteState {
  const FavoriteLoader({
    super.videos,
  });

  @override
  List<Object?> get props => [videos];
}
