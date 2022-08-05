import 'package:equatable/equatable.dart';
import 'package:sport_app/model/users.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends SignUpEvent {
  final UserInformation? userInformation;
  final String? password;
  GetUserEvent({
    this.userInformation,
    this.password,
  });
  @override
  List<Object?> get props => [userInformation, password];
}

class CreateNewAccountEvent extends SignUpEvent {
  final String? email;
  final String? password;
  CreateNewAccountEvent({this.email, this.password});
  @override
  List<Object?> get props => [email, password];
}
