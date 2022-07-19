import 'package:sport_app/bloc/splash/bloc/splash_event.dart';
import 'package:sport_app/bloc/splash/bloc/splash_state.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/resource/app_key_name.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState.initstate()) {
    on<CheckLoginEvent>(_onCheckLogin);
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<void> emitter) async {
    if (SharedPreferencesHelper.shared.prefs!.getString(AppKeyName.uid) != null) {
      Future.delayed(Duration(seconds: Constants.twoSecondDelay)).then(
        (value) => NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.main),
      );
    } else {
      Future.delayed(Duration(seconds: Constants.twoSecondDelay)).then(
        (value) => NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.login),
      );
    }
  }

  static SplashBloc of(BuildContext context) => BlocProvider.of<SplashBloc>(context);
}
