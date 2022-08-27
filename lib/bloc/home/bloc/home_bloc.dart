import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/resource/resource.dart';
import '../../../helper/shared_preferences_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initState()) {
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

  static HomeBloc of(BuildContext context) =>
      BlocProvider.of<HomeBloc>(context);
}
