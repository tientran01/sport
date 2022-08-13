import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/action.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/show_alert_dialog.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/profile/component/profile_item.dart';
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
  void initState() {
    super.initState();
    getIt.get<ProfileBloc>().add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: getIt.get<ProfileBloc>(),
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: AppStrings.profile,
            
          ),
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Constants.size20,
                vertical: Constants.size30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ImageCircle(
                      imageUrl: state.user?.photoUrl,
                      width: Constants.size100,
                      height: Constants.size100,
                      onTap: () {
                        _showActionSheet();
                      },
                      isEdit: true,
                    ),
                  ),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  Container(
                    padding: EdgeInsets.all(Constants.size15),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(Constants.size10),
                    ),
                    child: Column(
                      children: [
                        ProfileItem(
                          isChange: true,
                          text: AppStrings.nickName,
                          userInformation: state.user?.displayName,
                          onTap: () {
                            ShowAlertDialog.showAlertDialog(
                              context: context,
                              content: state.user?.displayName ?? "",
                              title: AppStrings.editDisplayName,
                              onChanged: (String displayName) {
                                getIt.get<ProfileBloc>().add(
                                      GetDisplayNameFromTextFieldEvent(
                                          displayName: displayName),
                                    );
                              },
                              onPressed: () {
                                getIt
                                    .get<ProfileBloc>()
                                    .add(EditDisplayNameEvent());
                                NavigationService.navigatorKey.currentState
                                    ?.pop();
                              },
                            );
                          },
                        ),
                        ProfileItem(
                          text: AppStrings.email,
                          userInformation: state.user?.email,
                        ),
                        const ProfileItem(
                          text: AppStrings.phone,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        width: Constants.size120,
                        text: AppStrings.logout,
                        onTap: () {
                          getIt.get<ProfileBloc>().add(ButtonSignOutEvent());
                        },
                        bgColor: AppColor.arsenic,
                        textColor: AppColor.white,
                      ),
                      Button(
                        width: Constants.size200,
                        text: AppStrings.deleteAccount,
                        onTap: () {
                          getIt.get<ProfileBloc>().add(DeleteProfileEvent());
                        },
                        bgColor: AppColor.white,
                        textColor: AppColor.black,
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showActionSheet() {
    ActionComponent.shared.showActionUploadImage(
      context: context,
      onCamera: () {
        OpenImagePicker.getImage(
          getImageFromCamera: true,
          value: (String image) {
            setState(
              () {
                imagePath = image;
                NavigationService.navigatorKey.currentState?.pop();
                FirebaseHelper.shared.uploadImageUser(imagePath: imagePath);
              },
            );
          },
        );
      },
      onGalley: () {
        OpenImagePicker.getImage(
          getImageFromCamera: false,
          value: (String image) {
            setState(
              () {
                imagePath = image;
                NavigationService.navigatorKey.currentState?.pop();
                Loading.show();
                FirebaseHelper.shared
                    .uploadImageUser(imagePath: imagePath)
                    .then(
                  (value) {
                    getIt.get<ProfileBloc>().add(GetUserProfileEvent());
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
