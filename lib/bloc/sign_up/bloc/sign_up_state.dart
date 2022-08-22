import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String? email;
  final String? password;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final bool isValid;
  const SignUpState({
    this.email,
    this.password,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.isValid = false,
  });
  const SignUpState.initState() : this();

  SignUpState copyWith({
    String? email,
    String? password,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    bool isValid = false,
  }) {
    return SignUpState(
      email: email,
      password: password,
      displayName: displayName,
      photoUrl: photoUrl,
      phoneNumber: phoneNumber,
      isValid: isValid,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        photoUrl,
        displayName,
        phoneNumber,
        isValid,
      ];
}
