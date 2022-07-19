import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_button.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_key_name.dart';
import 'package:sport_app/resource/app_resource.dart';
import 'package:sport_app/resource/app_strings.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:sport_app/resource/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.profile,
        rightIconPath: AppResource.more,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: Constants.size30),
                Stack(
                  children: [
                    buildImage(),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: buildEditImage(),
                    ),
                  ],
                ),
                SizedBox(height: Constants.size20),
                buildName(),
                SizedBox(height: Constants.size30),
                CustomButton(
                  text: AppStrings.signOut,
                  onTap: () {
                    getIt.get<ProfileBloc>().add(ButtonSignOutEvent());
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildImage({
    String? photoUrl,
    VoidCallback? onTap,
  }) {
    return ClipOval(
      child: Image.network(
        photoUrl ?? Application.imageAvatar,
        fit: BoxFit.cover,
        width: Constants.sizeImage,
        height: Constants.sizeImage,
      ),
    );
  }

  Widget buildEditImage() {
    return Container(
      padding: EdgeInsets.all(Constants.size5),
      decoration: BoxDecoration(
        color: AppColor.hDDDDDD,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColor.hFFFFFF,
          width: Constants.size5,
        ),
      ),
      child: Image.asset(
        AppResource.edit,
        color: AppColor.h413F42,
        width: Constants.sizeIcon,
      ),
    );
  }

  Widget buildName({
    String? displayName,
    String? email,
    String? phoneNumber,
  }) {
    String? displayName = SharedPreferencesHelper.shared.getString(AppKeyName.displayName);
    String? email = SharedPreferencesHelper.shared.getString(AppKeyName.email);
    return Column(
      children: [
        Text(
          displayName ?? "",
          style: AppStyle.nameSection,
        ),
        SizedBox(height: Constants.size5),
        Text(
          email ?? "",
          style: AppStyle.lightTitle,
        ),
      ],
    );
  }
}
