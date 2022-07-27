import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class UpdateBadgeEvent extends HomeEvent {
  final int? badgeCount;

  const UpdateBadgeEvent({this.badgeCount});
  @override
  List<Object?> get props => [badgeCount];
}
