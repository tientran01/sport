import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class GetEmailAndPasswordFormTextFieldEvent extends LoginEvent {
  final String? email;
  final String? password;
  const GetEmailAndPasswordFormTextFieldEvent({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LoginWithEmailAndPasswordEvent extends LoginEvent {}

class SignInWithGoogleEvent extends LoginEvent {}

class SignInWithFacebookEvent extends LoginEvent {}

class SignOutEvent extends LoginEvent {}
