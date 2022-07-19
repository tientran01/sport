import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  final String? newPasword;
  final String? email;
  const ForgetPasswordState({this.newPasword, this.email});
  ForgetPasswordState copyWith({
    String? newPassword,
    String? email,
  }) {
    return ForgetPasswordState(
      newPasword: newPasword,
      email: email,
    );
  }

  const ForgetPasswordState.initState() : this();
  @override
  List<Object?> get props => [newPasword, email];
}
