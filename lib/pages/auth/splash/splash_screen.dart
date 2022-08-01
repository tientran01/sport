import 'package:sport_app/bloc/splash/bloc/splash_bloc.dart';
import 'package:sport_app/bloc/splash/bloc/splash_event.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc splashBloc;
  @override
  void initState() {
    splashBloc = SplashBloc.of(context);
    splashBloc.add(const CheckLoginEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.splashScreen),
      ),
    );
  }
}