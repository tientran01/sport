import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_button.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/permission/open_image_picker.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        bloc: getIt.get(),
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.profile,
              rightIconPath: AppResource.more,
              onPressedLeft: () => NavigationService.navigatorKey.currentState
                  ?.pushNamed(AppRouteName.main),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: Constants.size30),
                    Stack(
                      children: [
                        buildImage(
                          imagePath: imagePath ??
                              SharedPreferencesHelper.shared
                                  .getString(AppKeyName.takeImage),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _showActionSheet(context),
                            child: buildEditImage(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Constants.size20),
                    buildName(
                      email: SharedPreferencesHelper.shared
                          .getString(AppKeyName.email),
                      displayName: SharedPreferencesHelper.shared
                          .getString(AppKeyName.displayName),
                    ),
                    SizedBox(height: Constants.size30),
                    CustomButton(
                      text: AppStrings.signOut,
                      onTap: () {
                        getIt.get<ProfileBloc>().add(ButtonSignOutEvent());
                      },
                    ),
                    SizedBox(height: Constants.size30),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildImage({String? imagePath}) {
    return (imagePath != null)
        ? ImageFile(
            imageFile: imagePath,
          )
        : CustomImageCircle(
            imageUrl: imagePath,
            width: Constants.sizeImage,
            height: Constants.sizeImage,
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
        width: Constants.size20,
      ),
    );
  }

  Widget buildName({
    String? displayName,
    String? email,
    String? phoneNumber,
  }) {
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

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(AppStrings.chooseProfilePhoto),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () => OpenImagePicker.getImage(
              getImageFromCamera: true,
              value: (String image) {
                setState(() {
                  imagePath = image;
                });
                SharedPreferencesHelper.shared.setString(
                  AppKeyName.takeImage,
                  imagePath ?? "",
                );
              },
            ),
            child: const Text(
              AppStrings.camera,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () => OpenImagePicker.getImage(
              getImageFromCamera: false,
              value: (String image) {
                setState(() {
                  imagePath = image;
                });
                SharedPreferencesHelper.shared.setString(
                  AppKeyName.takeImage,
                  imagePath ?? "",
                );
              },
            ),
            child: const Text(
              AppStrings.gallery,
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(AppStrings.cancel),
          )
        ],
      ),
    );
  }
}
