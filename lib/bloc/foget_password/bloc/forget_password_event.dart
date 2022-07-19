import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();
  @override
  List<Object?> get props => [];
}

class GetEmailAndCheckValidEvent extends ForgetPasswordEvent {
  final String? email;
  const GetEmailAndCheckValidEvent({this.email});
  @override
  List<Object?> get props => [email];
}

class SendEmailEvent extends ForgetPasswordEvent {}
