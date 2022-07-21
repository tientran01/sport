import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_button.dart';
import 'package:sport_app/helper/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.notification,
        onPressedLeft: () => NavigationService.navigatorKey.currentState?.pop(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: AppStrings.showScheduledNotification,
              onTap: () {
                NotificationService.shared.showScheduledNotification(
                  id: 1,
                  title: AppStrings.localNotificationTitle,
                  body: AppStrings.localNotificationBody,
                );
              },
            ),
            SizedBox(height: Constants.size20),
            CustomButton(
              text: AppStrings.showNotificationWithPayload,
              onTap: () {
                NotificationService.shared.showNotificationWithPayload(
                  id: 2,
                  title: AppStrings.localNotificationTitle,
                  body: AppStrings.localNotificationBody,
                  payload: AppRouteName.notificationDetail,
                );
              },
            ),
            SizedBox(height: Constants.size20),
          ],
        ),
      ),
    );
  }
}
