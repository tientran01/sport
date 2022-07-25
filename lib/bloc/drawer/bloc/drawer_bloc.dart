import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/drawer/bloc/drawer_event.dart';
import 'package:sport_app/bloc/drawer/bloc/drawer_state.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(const DrawerState.initState()) {
    on<ButtonProfileEvent>(_onButtonProfileEvent);
  }

  Future<void> _onButtonProfileEvent(
    ButtonProfileEvent event,
    Emitter<void> emitter,
  ) async {
    NavigationService.navigatorKey.currentState?.pushNamed(AppRouteName.profile);
  }

  static DrawerBloc of(BuildContext context) =>
      BlocProvider.of<DrawerBloc>(context);
}
