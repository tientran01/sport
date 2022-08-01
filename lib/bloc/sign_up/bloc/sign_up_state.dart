import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String? email;
  final String? password;
  final String? photoUrl;
  final String? displayName;
  final String? phoneNumber;
  const SignUpState({
    this.email,
    this.password,
    this.photoUrl,
    this.displayName,
    this.phoneNumber,
  });
  const SignUpState.initState() : this();

  SignUpState copyWith({
    String? email,
    String? password,
    String? photoUrl,
    String? displayName,
    String? phoneNumber,
  }) {
    return SignUpState(
      email: email,
      password: password,
      photoUrl: photoUrl,
      displayName: displayName,
      phoneNumber: phoneNumber,
    );
  }

  @override
  List<Object?> get props => [email, password, photoUrl, displayName, phoneNumber];
}
