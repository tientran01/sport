import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: AppStrings.notification,
          onPressedLeft: () {
            NavigationService.navigatorKey.currentState
                ?.pushNamed(AppRouteName.main);
          }),
      body: const Center(
        child: Text(AppStrings.notification),
      ),
    );
  }
}
