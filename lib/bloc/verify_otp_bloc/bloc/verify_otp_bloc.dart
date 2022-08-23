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
    UserCredential userCredential =
        await FirebaseHelper.shared.loginWithPhoneNumber(state.otpCode);
    User? user = userCredential.user;
    try {
      if (user != null) {
        final userInformation = UserInformation(
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
        );
        FirebaseHelper.shared.createUserInformation(userInformation);
        SharedPreferencesHelper.shared.setString(AppKeyName.uid, user.uid);
        NavigationService.navigatorKey.currentState?.pushReplacementNamed(
          AppRouteName.main,
          arguments: user,
        );
      }
    } on FirebaseAuthException catch (e) {
      Loading.showError(msg: e.toString());
    }
  }

  static VerifyOtpBloc of(BuildContext context) =>
      BlocProvider.of<VerifyOtpBloc>(context);
}
