import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends SignUpEvent {
  final String? email;
  final String? password;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  GetUserEvent({
    this.email,
    this.password,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
  });
  @override
  List<Object?> get props => [email, password, displayName, photoUrl, phoneNumber,];
}

class CreateNewAccountEvent extends SignUpEvent {
  final String? email;
  final String? password;
  CreateNewAccountEvent({this.email, this.password});
  @override
  List<Object?> get props => [email, password];
}
