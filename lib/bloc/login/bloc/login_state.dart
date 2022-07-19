import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? password;
  final String? email;
  const LoginState({
    this.password,
    this.email,
  });

  const LoginState.initState() : this();

  LoginState copyWith({
    String? password,
    String? email,
  }) {
    return LoginState(
      password: password,
      email: email,
    );
  }

  @override
  List<Object?> get props => [password, email];
}
