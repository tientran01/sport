import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/action.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/show_alert_dialog.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/l10n/s.dart';
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
          appBar: CustomAppBar(
            title: S.of(context).account,
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
                      color: AppColor.gainsboro.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(
                        Constants.size10,
                      ),
                    ),
                    child: Column(
                      children: [
                        ProfileItem(
                          isChange: true,
                          text: S.of(context).displayName,
                          userInformation: state.user?.displayName,
                          onTap: () {
                            ShowAlertDialog.showAlertDialog(
                              context: context,
                              content: state.user?.displayName ?? "",
                              title: S.of(context).editDisplayName,
                              onChanged: (String displayName) {
                                getIt.get<ProfileBloc>().add(
                                      GetDisplayNameFromTextFieldEvent(
                                        displayName: displayName,
                                      ),
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
                          text: S.of(context).email,
                          userInformation: state.user?.email,
                        ),
                        ProfileItem(
                          userInformation: state.user?.phoneNumber ?? "",
                          text: S.of(context).phoneNumber,
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
                        text: S.of(context).logout.toUpperCase(),
                        onTap: () {
                          getIt.get<ProfileBloc>().add(ButtonSignOutEvent());
                        },
                        bgColor: AppColor.viridianGreen,
                        textColor: AppColor.white,
                      ),
                      Button(
                        width: Constants.size200,
                        text: S.of(context).deleteAccount.toUpperCase(),
                        onTap: () {
                          _showAlertDeleteAccount(context);
                        },
                        bgColor: AppColor.viridianGreen.withOpacity(0.5),
                        textColor: AppColor.white,
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

  void _showAlertDeleteAccount(BuildContext context) {
    ShowAlertDialog.showAlertDialog(
      context: context,
      title: S.of(context).deleteAccountConfirm,
      defaultActionText: S.of(context).delete,
      onPressed: () {
        getIt.get<ProfileBloc>().add(DeleteAccountEvent());
      },
    );
  }
}
