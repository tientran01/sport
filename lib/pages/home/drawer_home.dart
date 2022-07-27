import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_state.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

import '../../bloc/profile/bloc/profile_event.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getIt.get<ProfileBloc>().add(GetUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: AppColor.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              GestureDetector(
                onTap: () {
                  NavigationService.navigatorKey.currentState
                      ?.pushNamed(AppRouteName.profile);
                },
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColor.jetStream,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<ProfileBloc, ProfileState>(
                              bloc: getIt.get<ProfileBloc>(),
                              builder: ((context, state) {
                                return Row(
                                  children: [
                                    ImageCircle(
                                      imageUrl: state.user?.photoUrl,
                                      width: Constants.sizeImage,
                                      height: Constants.sizeImage,
                                    ),
                                    SizedBox(
                                      width: Constants.size10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: state.user?.displayName ?? "",
                                            fontWeight: FontWeight.w600,
                                            fontSize: Constants.titleFontSize,
                                          ),
                                          SizedBox(
                                            height: Constants.size5,
                                          ),
                                          TextView(
                                            text: state.user?.email ?? "",
                                            fontSize: Constants.smallFontSize,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              })),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          child: Image.asset(
                            AppResource.close,
                            color: AppColor.darkSilver,
                            width: Constants.size20,
                          ),
                          onTap: () {
                            Scaffold.of(context).closeDrawer();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              buildDrawerItem(
                title: AppStrings.sync,
                iconPath: AppResource.sync,
              ),
              buildDrawerItem(
                title: AppStrings.notification,
                iconPath: AppResource.notification,
                onTap: () {},
              ),
              buildDrawerItem(
                title: AppStrings.paymentRequest,
                iconPath: AppResource.money,
              ),
              buildDrawerItem(
                title: AppStrings.history,
                iconPath: AppResource.history,
              ),
              buildDrawerItem(
                title: AppStrings.chartReport,
                iconPath: AppResource.chart,
              ),
              const Divider(),
              buildDrawerItem(
                title: AppStrings.setting,
                iconPath: AppResource.setting,
              ),
              buildDrawerItem(
                title: AppStrings.info,
                iconPath: AppResource.info,
              ),
              buildDrawerItem(
                title: AppStrings.logout,
                iconPath: AppResource.logout,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDrawerItem({
    String? title,
    String? iconPath,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Image.asset(
        iconPath ?? "",
        width: Constants.sizeIcon,
      ),
      title: TextView(
        text: title ?? "",
        fontSize: Constants.subtitleFontSize,
      ),
      onTap: () {
        onTap;
        setState(() {});
      },
    );
  }
}
