import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/resource/resource.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.notification,
      ),
      body: Center(
        child: Text("Notification Detail"),
      ),
    );
  }
}
