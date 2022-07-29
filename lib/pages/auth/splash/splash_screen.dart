import 'package:sport_app/bloc/splash/bloc/splash_bloc.dart';
import 'package:sport_app/bloc/splash/bloc/splash_event.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sport_app/resource/resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late SplashBloc splashBloc;
  bool copAnimated = false;
  bool animateCafeText = false;
  late AnimationController animationController;

  @override
  void initState() {
    splashBloc = SplashBloc.of(context);
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.addListener(() {
      if (animationController.value > 0.7) {
        animationController.stop();
        copAnimated = true;
      }
    });
    splashBloc.add(const CheckLoginEvent());
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: Constants.oneSecondDelay),
            height: copAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.circular(copAnimated ? Constants.size45 : 0.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Visibility(
                      visible: !copAnimated,
                      child: Lottie.asset(
                        AppResource.coffeeJson,
                        controller: animationController,
                        onLoaded: (composition) {
                          animationController
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
                    ),
                    Visibility(
                      visible: copAnimated,
                      child: Image.asset(
                        AppResource.coffee1,
                        height: Constants.size200,
                        width: Constants.size200,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
