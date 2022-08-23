import 'package:equatable/equatable.dart';

import '../../../helper/enum.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();
  @override
  List<Object?> get props => [];
}

class GetOtpFormFieldEvent extends VerifyOtpEvent {
  final String? otpCode;
  const GetOtpFormFieldEvent({this.otpCode});
  @override
  List<Object?> get props => [otpCode];
}

class ResendOtpCodeEvent extends VerifyOtpEvent {
  final String? phoneNumber;
  const ResendOtpCodeEvent({this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

class LoginWithPhoneNumberEvent extends VerifyOtpEvent {}

class VerifyOtpFailedEvent extends VerifyOtpEvent {
  final FirebaseExceptionType? error;
  const VerifyOtpFailedEvent({this.error});
  @override
  List<Object?> get props => [error];
}