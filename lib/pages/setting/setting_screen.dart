import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_event.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
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
    getIt.get<ProfileBloc>().add(GetUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.setting,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.size20,
          vertical: Constants.size10,
        ),
        child: Column(
          children: [
            BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc()
                ..add(
                  GetUserProfile(),
                ),
              child: BlocBuilder<ProfileBloc, ProfileState>(
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
                            iconPath: AppResource.crown,
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
            ),
          ],
        ),
      ),
    );
  }
}
