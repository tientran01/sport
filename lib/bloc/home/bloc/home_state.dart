import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeState extends Equatable {
  final int? badge;
  const HomeState({
    this.badge,
  });
  const HomeState.initState() : this();
  HomeState copyWith({
    User? user,
    int? badge,
  }) {
    return HomeState(
      badge: badge,
    );
  }

  @override
  List<Object?> get props => [
        badge,
      ];
}
