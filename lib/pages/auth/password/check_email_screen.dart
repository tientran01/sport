import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.checkValidEmail,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.size30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: AppStrings.messCheckEmail.toUpperCase(),
              ),
              SizedBox(height: Constants.size30),
              Button(
                text: AppStrings.login.toUpperCase(),
                onTap: () => NavigationService.navigatorKey.currentState
                    ?.pushNamed(AppRouteName.login),
              )
            ],
          ),
        ));
  }
}
