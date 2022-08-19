import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_event.dart';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(const VerifyOtpState.initState()) {
    on<GetOtpFormFieldEvent>(_onGetOtpFormField);
    on<ResendOtpCodeEvent>(_onResendOtpCode);
    on<LoginWithPhoneNumberEvent>(_onLoginWithPhoneNumber);
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

  Future<void> _onLoginWithPhoneNumber(
    LoginWithPhoneNumberEvent event,
    Emitter<void> emitter,
  ) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: FirebaseHelper.shared.verificationId ?? "",
      smsCode: state.otpCode ?? "",
    );
    try {
      Loading.show();
      var result =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (result.user != null) {
        Loading.dismiss();
        UserInformation userInformation = UserInformation(
          phoneNumber: result.user?.phoneNumber,
        );
        SharedPreferencesHelper.shared.setString(
          AppKeyName.uid,
          result.user!.uid,
        );
        await FirebaseHelper.shared.createUserInformation(userInformation);
        NavigationService.navigatorKey.currentState?.pushNamed(
          AppRouteName.main,
        );
      }
    } on FirebaseAuthException {
      Loading.showError(AppStrings.error);
    }
  }

  static VerifyOtpBloc of(BuildContext context) =>
      BlocProvider.of<VerifyOtpBloc>(context);
}
