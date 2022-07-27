import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
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
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getIt.get<ProfileBloc>().add(GetUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: getIt.get<ProfileBloc>(),
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
              padding: EdgeInsets.all(Constants.size10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Constants.size30),
                    // ImageCircle(
                      imageUrl: state.user?.photoUrl,
                      width: Constants.sizeImage,
                      height: Constants.sizeImage,
                      onTap: () => _showActionSheet(context),
                    ),
                    SizedBox(height: Constants.size20),
                    buildName(
                      email: state.user?.email,
                      displayName: state.user?.displayName,
                    ),
                    SizedBox(height: Constants.size30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                          width: MediaQuery.of(context).size.width / 2,
                          text: AppStrings.signOut,
                          onTap: () {
                            getIt.get<ProfileBloc>().add(ButtonSignOutEvent());
                          },
                        ),
                        Button(
                          text: AppStrings.edit,
                          bgColor: AppColor.arsenic,
                          width: MediaQuery.of(context).size.width / 3,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: Container(
                                  padding: EdgeInsets.all(Constants.size5),
                                  height: Constants.size200,
                                  child: Column(
                                    children: [
                                      const TextView(
                                        text:
                                            "${AppStrings.edit} ${AppStrings.displayName}",
                                      ),
                                      SizedBox(
                                        height: Constants.size20,
                                      ),
                                      CustomTextField(
                                        hintText: state.user?.displayName ??
                                            AppStrings.displayNameInput,
                                        title: AppStrings.displayName,
                                        type: TextFieldType.normal,
                                        onChanged: (String displayName) {
                                          getIt.get<ProfileBloc>().add(
                                                GetDisplayNameFromTextFieldEvent(
                                                  displayName: displayName,
                                                ),
                                              );
                                        },
                                      ),
                                      SizedBox(
                                        height: Constants.size20,
                                      ),
                                      Button(
                                        text: AppStrings.edit,
                                        onTap: () {
                                          getIt.get<ProfileBloc>().add(
                                                EditDisplayNameEvent(),
                                              );
                                          NavigationService
                                              .navigatorKey.currentState
                                              ?.pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: Constants.size30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildName({
    String? displayName,
    String? email,
    String? phoneNumber,
  }) {
    return Column(
      children: [
        TextView(
          text: displayName ?? "",
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: Constants.size5),
        TextView(
          text: email ?? "",
          textColor: AppColor.darkSilver,
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
                  NavigationService.navigatorKey.currentState?.pop();
                  FirebaseHelper.shared.uploadImageUser(imagePath: imagePath);
                });
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
                  NavigationService.navigatorKey.currentState?.pop();
                  Loading.show();
                  FirebaseHelper.shared
                      .uploadImageUser(imagePath: imagePath)
                      .then((value) {
                    getIt.get<ProfileBloc>().add(GetUserProfile());
                  });
                });
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
