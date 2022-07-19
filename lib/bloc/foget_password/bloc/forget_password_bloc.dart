import 'package:sport_app/bloc/foget_password/bloc/forget_password_event.dart';
import 'package:sport_app/bloc/foget_password/bloc/forget_password_state.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resource/app_route_name.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(const ForgetPasswordState.initState()) {
    on<GetEmailAndCheckValidEvent>(_onGetEmailAndCheckValid);
    on<SendEmailEvent>(_onSendEmail);
  }

  Future<void> _onGetEmailAndCheckValid(
    GetEmailAndCheckValidEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(email: event.email));
  }

  Future<void> _onSendEmail(SendEmailEvent event, Emitter<void> emitter) async {
    await FirebaseHelper.shared.resetPasswordWithEmail(email: state.email);
    NavigationService.navigatorKey.currentState
        ?.pushNamed(AppRouteName.checkEmail);
  }

  static ForgetPasswordBloc of(BuildContext context) =>
      BlocProvider.of<ForgetPasswordBloc>(context);
}
