import 'package:sport_app/bloc/splash/bloc/splash_bloc.dart';
import 'package:sport_app/bloc/splash/bloc/splash_event.dart';
import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:flutter/material.dart';
import '../../../resource/app_strings.dart';

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
    super.initState();
    splashBloc.add(const CheckLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.splashScreen,
              style: AppStyle.title,
            ),
            SizedBox(height: Constants.size10),
            const CircularProgressIndicator(
              color: AppColor.h413F42,
            )
          ],
        ),
      ),
    );
  }
}
