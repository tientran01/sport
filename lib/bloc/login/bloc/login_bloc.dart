// ignore_for_file: empty_catches

import 'package:sport_app/bloc/login/bloc/login_event.dart';
import 'package:sport_app/bloc/login/bloc/login_state.dart';
import 'package:sport_app/helper/error.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helper/loading.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState.initState()) {
    on<GetEmailAndPasswordFormTextFieldEvent>(
        _onGetEmailAndPasswordFormTextField);
    on<LoginWithFirebaseEvent>(_onLoginWithFirebase);
    on<SignUpEvent>(_onSignUp);
    on<SignInWithPhoneNumberEvent>(_onSignInWithPhoneNumber);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignInWithFacebookEvent>(_onSignInWithFacebook);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onGetEmailAndPasswordFormTextField(
      GetEmailAndPasswordFormTextFieldEvent event, Emitter<void> emit) async {
    emit(
      state.copyWith(
        email: event.email ?? state.email,
        password: event.password ?? state.password,
      ),
    );
  }

  Future<User?> _onLoginWithFirebase(
    LoginWithFirebaseEvent event,
    Emitter<void> emitter,
  ) async {
    try {
      Loading.show(AppStrings.loading);
      User? user = await FirebaseHelper.shared.loginWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      if (user != null) {
        Loading.dismiss();
        SharedPreferencesHelper.shared.setString(AppKeyName.uid, user.uid);
        await FirebaseHelper.shared.createUser();
        NavigationService.navigatorKey.currentState?.pushNamed(
          AppRouteName.main,
          arguments: user,
        );
        return Future.value(user);
      }
      return Future.error(Error.loginWithFirebaseError);
    } on FirebaseAuthException catch (e) {
      Loading.showError(AppStrings.error);
      return Future.error(e.message!);
    }
  }

  Future<void> _onSignUp(
    SignUpEvent event,
    Emitter<void> emitter,
  ) async {
    NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.signUp);
  }

  Future<void> _onSignInWithPhoneNumber(
    SignInWithPhoneNumberEvent event,
    Emitter<void> emitter,
  ) async {
    NavigationService.navigatorKey.currentState
        ?.pushNamed(AppRouteName.phoneInput);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<void> emitter,
  ) async {
    await FirebaseHelper.shared.signInWithGoogle();
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebookEvent event,
    Emitter<void> emitter,
  ) async {
    await FirebaseHelper.shared.signInWithFacebook();
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<void> emitter,
  ) async {
    try {
      FirebaseHelper.shared.signOut();
      SharedPreferencesHelper.shared.logout();
      NavigationService.navigatorKey.currentState
          ?.pushNamed(AppRouteName.login);
    } catch (e) {}
  }

  static LoginBloc of(BuildContext context) =>
      BlocProvider.of<LoginBloc>(context);
}
