import 'package:sport_app/bloc/foget_password/bloc/forget_password_event.dart';
import 'package:sport_app/bloc/foget_password/bloc/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(const ForgetPasswordState.initState()) {
    on<GetEmailAndCheckValidEvent>(_onGetEmailAndCheckValid);
  }

  Future<void> _onGetEmailAndCheckValid(
    GetEmailAndCheckValidEvent event,
    Emitter<void> emitter,
  ) async {
    emitter(state.copyWith(email: event.email));
  }

  static ForgetPasswordBloc of(BuildContext context) =>
      BlocProvider.of<ForgetPasswordBloc>(context);
}
