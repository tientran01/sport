import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final int? badge;
  const HomeState({
    this.badge,
  });
  const HomeState.initState() : this();
  HomeState copyWith({
    int? badge,
  }) {
    return HomeState(
      badge: badge,
    );
  }

  @override
  List<Object?> get props => [badge];
}
