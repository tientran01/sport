import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
   const SplashEvent();
  @override
  List<Object?> get props => [];
}

class CheckLoginEvent extends SplashEvent {
  final String? uid;
  const CheckLoginEvent({this.uid});
  @override
  List<Object?> get props => [uid];
}
