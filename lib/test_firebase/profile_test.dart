import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/app_strings.dart';
import 'package:sport_app/router/navigation_service.dart';

class ProfileTest extends StatelessWidget {
  const ProfileTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.profileTest,
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseHelper.shared.getUserByUid(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(AppStrings.error);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text(AppStrings.loading);
          }
          DocumentSnapshot data = snapshot.data as DocumentSnapshot;
          Users user = Users.fromJson(data.data() as Map<String, dynamic>);
          return Text(user.displayName ?? "");
        },
      ),
    );
  }
}
