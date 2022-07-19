import 'package:equatable/equatable.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();
  @override
  List<Object?> get props => [];
}

class GetPhoneFromFieldAndValidateEvent extends PhoneAuthEvent {
  final String? phoneNumber;
  const GetPhoneFromFieldAndValidateEvent({this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

//nhap sdt, otp gui qua sms
class SendOtpToPhoneAuthEvent extends PhoneAuthEvent {
  final String? phoneNumber;
  const SendOtpToPhoneAuthEvent({this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

//xac thuc otp fail
class VerificationFailedEvent extends PhoneAuthEvent {
  final String? error;
  const VerificationFailedEvent({this.error});
  @override
  List<Object?> get props => [error];
}
