import 'package:equatable/equatable.dart';

class PhoneAuthState extends Equatable {
  final String? phoneNumber;
  final String? error;
  final String? otpCode;
  final String? verificationId;
  final int? token;
  const PhoneAuthState({
    this.phoneNumber,
    this.error,
    this.otpCode,
    this.verificationId,
    this.token,
  });

  const PhoneAuthState.initState() : this();

  PhoneAuthState copyWith({
    String? phoneNumber,
    String? error,
    String? otpCode,
    String? verificationId,
    int? token,
  }) {
    return PhoneAuthState(
      phoneNumber: phoneNumber,
      error: error,
      otpCode: otpCode,
      verificationId: verificationId,
      token: token,
    );
  }

  @override
  List<Object?> get props =>
      [phoneNumber, error, otpCode, verificationId, token];
}
