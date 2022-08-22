import 'package:sport_app/bloc/login/bloc/login_event.dart';
import 'package:sport_app/bloc/login/bloc/login_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/model/users.dart';
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
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
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
        isValid: state.email != null || state.password != null,
      ),
    );
  }

  Future<void> _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<void> emitter,
  ) async {
    try {
      Loading.show();
      User? user = await FirebaseHelper.shared.loginWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      if (user != null) {
        Loading.dismiss();
        SharedPreferencesHelper.shared.setString(AppKeyName.uid, user.uid);
        NavigationService.navigatorKey.currentState?.pushReplacementNamed(
          AppRouteName.main,
          arguments: user,
        );
      }
    } on FirebaseAuthException catch (e) {
      Loading.showError(e.toString());
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<void> emitter,
  ) async {
    UserCredential userCredential =
        await FirebaseHelper.shared.signInWithGoogle();
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
      Loading.showError(e.toString());
    }
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebookEvent event,
    Emitter<void> emitter,
  ) async {
    UserCredential userCredential =
        await FirebaseHelper.shared.signInWithFacebook();
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
        SharedPreferencesHelper.shared.setString(
          AppKeyName.uid,
          user.uid,
        );
        NavigationService.navigatorKey.currentState?.pushReplacementNamed(
          AppRouteName.main,
          arguments: user,
        );
      }
    } on FirebaseAuthException catch (e) {
      Loading.showError(e.toString());
    }
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<void> emitter,
  ) async {
    try {
      FirebaseHelper.shared.signOut();
      SharedPreferencesHelper.shared.removeUid();
      NavigationService.navigatorKey.currentState?.pushReplacementNamed(
        AppRouteName.login,
      );
    } catch (e) {
      Loading.showError(e.toString());
    }
  }

  static LoginBloc of(BuildContext context) =>
      BlocProvider.of<LoginBloc>(context);
}
