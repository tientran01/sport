import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeState extends Equatable {
  final User? user;
  final int? badge;
  const HomeState({
    this.user,
    this.badge,
  });
  const HomeState.initState() : this();
  HomeState copyWith({
    User? user,
    int? badge,
  }) {
    return HomeState(
      user: user,
      badge: badge,
    );
  }

  @override
  List<Object?> get props => [
        user,
        badge,
      ];
}
