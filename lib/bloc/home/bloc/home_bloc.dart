import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/resource/app_key_name.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helper/shared_preferences_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initState()) {
    on<ShowProfileEvent>(_onShowProfile);
    on<UpdateBadgeEvent>(_onUpdateBadge);
  }

  Future<void> _onUpdateBadge(
    UpdateBadgeEvent event,
    Emitter<void> emitter,
  ) async {
    int? badgeCount = ((event.badgeCount ?? state.badge) ?? 0);
    emitter(state.copyWith(badge: badgeCount));
    await SharedPreferencesHelper.shared.setInt(
      AppKeyName.badgeCount,
      badgeCount,
    );
  }

  Future<void> _onShowProfile(
    ShowProfileEvent event,
    Emitter<void> emitter,
  ) async {
    NavigationService.navigatorKey.currentState?.pushNamed(
      AppRouteName.showUser,
      arguments: event.user ?? state.user,
    );
  }


  static HomeBloc of(BuildContext context) =>
      BlocProvider.of<HomeBloc>(context);
}
