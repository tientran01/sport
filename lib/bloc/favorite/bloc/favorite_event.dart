import 'package:equatable/equatable.dart';
import 'package:sport_app/model/video.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object?> get props => [];
}

class AddVideoToFavoriteEvent extends FavoriteEvent {
  final Video? video;
  const AddVideoToFavoriteEvent({
    this.video,
  });
  @override
  List<Object?> get props => [video];
}
