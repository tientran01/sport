import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app/bloc/splash/bloc/splash_bloc.dart';
import 'package:sport_app/bloc/splash/bloc/splash_event.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/resource/resource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getIt.get<SplashBloc>().add(const CheckLoginEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.size20,
        ),
        color: AppColor.persianGreen.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppResource.connect,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                horizontal: Constants.size10,
                vertical: Constants.size30,
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(Constants.size15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.quicksand(
                        color: AppColor.arsenic,
                        fontWeight: FontWeight.w500,
                        fontSize: Constants.size25,
                      ),
                      children: [
                        const TextSpan(text: "Find out what's happening"),
                        TextSpan(
                          text: "\n in your world.",
                          style: GoogleFonts.dosis(
                            color: AppColor.viridianGreen,
                            fontWeight: FontWeight.w800,
                            fontSize: Constants.size30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Constants.size15),
                  TextView(
                    text: S.of(context).slogan_msg,
                    lineNumber: 3,
                    textColor: AppColor.arsenic.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
