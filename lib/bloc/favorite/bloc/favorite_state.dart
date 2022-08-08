import 'package:equatable/equatable.dart';
import 'package:sport_app/model/video.dart';

class FavoriteState extends Equatable {
  final List<Video?>? videos;
  final Video? video;
  const FavoriteState({this.videos, this.video});
  const FavoriteState.initState() : this();
  FavoriteState copyWith({
    List<Video?>? videos,
    Video? video,
  }) {
    return FavoriteState(
      videos: videos,
      video: video,
    );
  }

  @override
  List<Object?> get props => [videos, video];
}
