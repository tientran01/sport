import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final String? uid;
  const SplashState({this.uid});
  const SplashState.initstate() : this();

  SplashState copyWith({
    String? uid,
  }) {
    return SplashState(
      uid: uid,
    );
  }

  @override
  List<Object?> get props => [uid];
}
