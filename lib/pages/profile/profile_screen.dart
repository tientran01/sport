import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/users.dart';
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
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseHelper.shared.getUserByUid(),
      builder: (context, snapshot) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          bloc: getIt.get(),
          builder: (context, state) {
            if (snapshot.hasData && snapshot.data!.exists) {
              DocumentSnapshot data = snapshot.data as DocumentSnapshot;
              Users user = Users.fromJson(data.data() as Map<String, dynamic>);
              return Scaffold(
                appBar: CustomAppBar(
                  title: AppStrings.profile,
                  rightIconPath: AppResource.more,
                  onPressedLeft: () => NavigationService
                      .navigatorKey.currentState
                      ?.pushNamed(AppRouteName.main),
                ),
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(Constants.size10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: Constants.size30),
                          Stack(
                            children: [
                              buildImage(
                                imagePath: user.photoUrl,
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
                            email: user.email,
                            displayName: user.displayName,
                          ),
                          SizedBox(height: Constants.size30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button(
                                width: MediaQuery.of(context).size.width / 2,
                                text: AppStrings.signOut,
                                onTap: () {
                                  getIt
                                      .get<ProfileBloc>()
                                      .add(ButtonSignOutEvent());
                                },
                              ),
                              Button(
                                text: AppStrings.edit,
                                bgColor: AppColor.h413F42,
                                width: MediaQuery.of(context).size.width / 3,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      content: Container(
                                        padding:
                                            EdgeInsets.all(Constants.size5),
                                        height: Constants.size200,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${AppStrings.edit} ${AppStrings.displayName}",
                                              style: AppStyle.darkText(),
                                            ),
                                            SizedBox(
                                              height: Constants.size20,
                                            ),
                                            CustomTextField(
                                              hintText: user.displayName ??
                                                  AppStrings.displayNameInput,
                                              title: AppStrings.displayName,
                                              type: TextFieldType.normal,
                                              onChanged: (String displayName) {
                                                getIt.get<ProfileBloc>().add(
                                                      GetDisplayNameFromTextFieldEvent(
                                                        displayName:
                                                            displayName,
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
            }
            return Container();
          },
        );
      },
    );
  }

  Widget buildImage({String? imagePath}) {
    return CustomImageCircle(
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
          style: AppStyle.darkText(
            fontSize: Constants.titleFontSize,
          ),
        ),
        SizedBox(height: Constants.size5),
        Text(
          email ?? "",
          style: AppStyle.lightDarkText(
            fontSize: Constants.subtitleFontSize,
          ),
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
                  FirebaseHelper.shared.uploadImageUser(imagePath: imagePath);
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
