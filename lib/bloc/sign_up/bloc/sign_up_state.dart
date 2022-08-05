import 'package:equatable/equatable.dart';
import 'package:sport_app/model/users.dart';

class SignUpState extends Equatable {
  final UserInformation? userInformation;
  final String? password;
  const SignUpState({
    this.userInformation,
    this.password,
  });
  const SignUpState.initState() : this();

  SignUpState copyWith({
    UserInformation? userInformation,
    String? password,
  }) {
    return SignUpState(
      userInformation: userInformation,
      password: password,
    );
  }

  @override
  List<Object?> get props => [userInformation, password];
}
