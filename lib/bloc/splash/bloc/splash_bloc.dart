import 'package:sport_app/bloc/splash/bloc/splash_event.dart';
import 'package:sport_app/bloc/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState.initstate()) {
    on<CheckLoginEvent>(_onCheckLogin);
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<void> emitter) async {
    // if (SharedPreferencesHelper.shared.prefs!.getString(AppKeyName.uid) !=
    //     null) {
    //   Future.delayed(Duration(seconds: Constants.twoSecondDelay)).then(
    //     (value) => NavigationService.navigatorKey.currentState
    //         ?.pushReplacementNamed(AppRouteName.app),
    //   );
    // } else {
    //   Future.delayed(Duration(seconds: Constants.twoSecondDelay)).then(
    //     (value) =>
    //         NavigationService.navigatorKey.currentState?.pushReplacementNamed(
    //       AppRouteName.login,
    //     ),
    //   );
    // }
  }

  static SplashBloc of(BuildContext context) =>
      BlocProvider.of<SplashBloc>(context);
}
