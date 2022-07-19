import 'package:equatable/equatable.dart';

import '../../../helper/enum.dart';

class VerifyOtpState extends Equatable {
  final String? phoneNumber;
  final String? otpCode;
  final FirebaseExceptionType? error;
  const VerifyOtpState({
    this.phoneNumber,
    this.otpCode,
    this.error
  });
  const VerifyOtpState.initState() : this();

  VerifyOtpState copyWith({
    String? phoneNumber,
    String? otpCode,
    FirebaseExceptionType? error,
  }) {
    return VerifyOtpState(
      phoneNumber: phoneNumber,
      otpCode: otpCode,
      error: error
    );
  }

  @override
  List<Object?> get props => [phoneNumber, otpCode, error];
}
