import 'package:sport_app/bloc/phone_auth/bloc/phone_auth_event.dart';
import 'package:sport_app/bloc/phone_auth/bloc/phone_auth_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc() : super(const PhoneAuthState.initState()) {
    on<GetPhoneFromFieldAndValidateEvent>(_onGetPhoneFromFieldAndValidate);
    on<SendOtpToPhoneAuthEvent>(_onSendOtpPhoneNumber);
  }
  Future<void> _onGetPhoneFromFieldAndValidate(
    GetPhoneFromFieldAndValidateEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(
      state.copyWith(
        phoneNumber: event.phoneNumber ?? "",
      ),
    );
  }

  Future<void> _onSendOtpPhoneNumber(
    SendOtpToPhoneAuthEvent event,
    Emitter<PhoneAuthState> emitter,
  ) async {
    FirebaseHelper.shared.verifyPhoneNumber(
      phoneNumber: state.phoneNumber ?? "",
      onVerificationCompleted: (AuthCredential authCredential) async {},
      onVerificationFailed: (FirebaseAuthException error) {
        add(VerificationFailedEvent(error: error.code));
      },
      onCodeSent: (String? verificationID, int? resentToken) {
        NavigationService.navigatorKey.currentState?.pushNamed(
          AppRouteName.phoneOtp,
          arguments: state.phoneNumber ?? event.phoneNumber,
        );
      },
      onCodeAutoRetrievalTimeout: (verificationID) {},
    );
  }

  static PhoneAuthBloc of(BuildContext context) =>
      BlocProvider.of<PhoneAuthBloc>(context);
}
