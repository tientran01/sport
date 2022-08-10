import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app/bloc/splash/bloc/splash_bloc.dart';
import 'package:sport_app/bloc/splash/bloc/splash_event.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashBloc splashBloc;
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(
      seconds: Constants.twoSecondDelay,
    ),
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-3.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ),
  );
  @override
  void initState() {
    splashBloc = SplashBloc.of(context);
    splashBloc.add(const CheckLoginEvent());
    _offsetAnimation;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.jetStream,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppResource.logo,
                width: Constants.size150,
              ),
            ),
            SlideTransition(
              position: _offsetAnimation,
              child: Text(
                AppStrings.logo,
                style: GoogleFonts.mouseMemoirs(
                  color: AppColor.arsenic,
                  fontSize: Constants.size45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
