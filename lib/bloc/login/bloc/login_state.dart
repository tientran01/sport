import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String? password;
  final String? email;
  final bool isValid;
  const LoginState({
    this.password,
    this.email,
    this.isValid = false,
  });

  const LoginState.initState() : this();

  LoginState copyWith({
    String? password,
    String? email,
    bool isValid = false,
  }) {
    return LoginState(
      password: password,
      email: email,
      isValid: isValid,
    );
  }

  @override
  List<Object?> get props => [password, email, isValid];
}
