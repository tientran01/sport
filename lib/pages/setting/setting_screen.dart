import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<ProfileBloc>().add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.setting,
        isPop: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                bloc: getIt.get<ProfileBloc>(),
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      NavigationService.navigatorKey.currentState
                          ?.pushNamed(AppRouteName.profile);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: ImageCircle(
                            width: Constants.size100,
                            height: Constants.size100,
                            imageUrl: state.user?.photoUrl,
                          ),
                        ),
                        SizedBox(
                          width: Constants.size15,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: state.user?.displayName,
                                fontSize: Constants.size20,
                                fontWeight: FontWeight.w800,
                              ),
                              TextView(
                                text: state.user?.email,
                                fontSize: Constants.size15,
                                textColor: AppColor.darkSilver,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationService.navigatorKey.currentState
                                ?.pushNamed(AppRouteName.profile);
                          },
                          child: Image.asset(
                            AppResource.rightArrow,
                            width: Constants.size20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: Constants.size40,
              ),
              TextView(
                text: AppStrings.justForYou,
                fontSize: Constants.size17,
                fontWeight: FontWeight.w800,
                textColor: AppColor.viridianGreen,
              ),
              SizedBox(
                height: Constants.size12,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.size20,
                ),
                decoration: BoxDecoration(
                  color: AppColor.gainsboro.withOpacity(.4),
                  borderRadius: BorderRadius.circular(Constants.size15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSettingItem(
                      context,
                      onTap: () {
                        NavigationService.navigatorKey.currentState
                            ?.pushNamed(AppRouteName.favorite);
                      },
                      text: AppStrings.favorites,
                    ),
                    buildSettingItem(
                      context,
                      text: AppStrings.bookmark,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Constants.size30,
              ),
              TextView(
                text: AppStrings.setting,
                fontSize: Constants.size17,
                fontWeight: FontWeight.w800,
                textColor: AppColor.viridianGreen,
              ),
              SizedBox(
                height: Constants.size12,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.size20,
                ),
                decoration: BoxDecoration(
                  color: AppColor.gainsboro.withOpacity(.4),
                  borderRadius: BorderRadius.circular(Constants.size15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSettingItem(
                      context,
                      text: AppStrings.language,
                      onTap: () {
                        NavigationService.navigatorKey.currentState
                            ?.pushNamed(AppRouteName.changeLanguage);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingItem(BuildContext context,
      {required String text, required VoidCallback onTap}) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Constants.size20),
        child: Row(
          children: [
            TextView(
              text: text,
              textColor: AppColor.arsenic,
              fontSize: Constants.size17,
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Image.asset(
                AppResource.rightArrow,
                width: Constants.size15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
