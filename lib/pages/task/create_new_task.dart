import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.size20,
          vertical: Constants.size30,
        ),
        child: Column(
          children: [
            TextView(
              text: AppStrings.createNewTask,
              fontSize: Constants.size25,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
      ),
    );
  }
}
