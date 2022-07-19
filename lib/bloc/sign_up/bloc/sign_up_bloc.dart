import 'package:sport_app/bloc/sign_up/bloc/sign_up_event.dart';
import 'package:sport_app/bloc/sign_up/bloc/sign_up_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/resource/app_key_name.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:sport_app/resource/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/navigation_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState.initState()) {
    on<GetEmailAndPasswordFormTextFieldEvent>(
        _onGetEmailAndPasswordFormTextField);
    on<CreateNewAccountEvent>(_onCreateNewAccount);
  }

  Future<void> _onGetEmailAndPasswordFormTextField(
      GetEmailAndPasswordFormTextFieldEvent event,
      Emitter<void> emitter) async {
    emitter(
      state.copyWith(
        email: event.email ?? state.email,
        password: event.password ?? state.password,
      ),
    );
  }

  Future<User?> _onCreateNewAccount(
      CreateNewAccountEvent event, Emitter<void> emitter) async {
    try {
      User? user = await FirebaseHelper.shared.signUpWithEmailAndPassword(
        email: event.email ?? state.email,
        password: event.password ?? state.password,
      );
      if (user != null) {
        NavigationService.navigatorKey.currentState
            ?.pushNamed(AppRouteName.main);
        SharedPreferencesHelper.shared.prefs
            ?.setString(AppKeyName.email, user.email ?? "");
        return Future.value(user);
      }
      return Future.error(AppStrings.error);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }

  static SignUpBloc of(BuildContext context) =>
      BlocProvider.of<SignUpBloc>(context);
}
