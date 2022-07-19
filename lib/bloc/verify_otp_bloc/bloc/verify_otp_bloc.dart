import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_event.dart';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(const VerifyOtpState.initState()) {
    on<GetOtpFormFieldEvent>(_onGetOtpFormField);
    on<ResendOtpCodeEvent>(_onResendOtpCode);
    on<SignUpWithPhoneNumberEvent>(_onSignUpWithPhoneNumber);
  }

  Future<void> _onGetOtpFormField(
      GetOtpFormFieldEvent event, Emitter<void> emitter) async {
    emitter(state.copyWith(otpCode: event.otpCode));
  }

  Future<void> _onResendOtpCode(
      ResendOtpCodeEvent event, Emitter<void> emitter) async {
    FirebaseHelper.shared.verifyPhoneNumber(
      phoneNumber: event.phoneNumber ?? '',
      onVerificationCompleted: (AuthCredential authCredential) async {},
      onVerificationFailed: (FirebaseAuthException error) {},
      onCodeSent: (String? verificationID, int? resentToken) {},
      onCodeAutoRetrievalTimeout: (verificationID) {},
    );
  }

  Future<void> _onSignUpWithPhoneNumber(
      SignUpWithPhoneNumberEvent event, Emitter<void> emitter) async {
    FirebaseHelper.shared.loginWithPhoneNumber(state.otpCode);
  }

  static VerifyOtpBloc of(BuildContext context) =>
      BlocProvider.of<VerifyOtpBloc>(context);
}
