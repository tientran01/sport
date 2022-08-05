import 'package:sport_app/bloc/sign_up/bloc/sign_up_event.dart';
import 'package:sport_app/bloc/sign_up/bloc/sign_up_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/resource.dart';

import '../../../router/navigation_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState.initState()) {
    on<GetUserEvent>(_onGetUser);
    on<CreateNewAccountEvent>(_onCreateNewAccount);
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<void> emitter) async {
    emitter(
      state.copyWith(
        userInformation: state.userInformation ?? event.userInformation,
        password:  state.password ?? event.password
      ),
    );
  }

  Future<void> _onCreateNewAccount(
      CreateNewAccountEvent event, Emitter<void> emitter) async {
    try {
      Loading.show();
      User? user = await FirebaseHelper.shared.signUpWithEmailAndPassword(
        email: event.email ?? state.userInformation?.email,
        password: event.password ?? state.password,
      );
      if (user != null) {
        Loading.dismiss();
        UserInformation userInformation = UserInformation(
          displayName: state.userInformation?.displayName,
          email: state.userInformation?.email,
          photoUrl: state.userInformation?.photoUrl,
        );
        SharedPreferencesHelper.shared.setString(AppKeyName.uid, user.uid);
        await FirebaseHelper.shared.createUserInformation(userInformation);
        NavigationService.navigatorKey.currentState?.pushNamed(
          AppRouteName.main,
          arguments: user,
        );
      }
      Loading.showError(AppStrings.error);
    } on FirebaseAuthException catch (e) {
      Loading.showError(e.message ?? '');
    }
  }

  static SignUpBloc of(BuildContext context) =>
      BlocProvider.of<SignUpBloc>(context);
}
