import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/drawer/bloc/drawer_bloc.dart';
import 'package:sport_app/bloc/drawer/bloc/drawer_event.dart';
import 'package:sport_app/bloc/drawer/bloc/drawer_state.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/resource.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseHelper.shared.getUserByUid(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          DocumentSnapshot data = snapshot.data as DocumentSnapshot;
          Users user = Users.fromJson(data.data() as Map<String, dynamic>);
          return BlocBuilder<DrawerBloc, DrawerState>(
            builder: (context, state) {
              return Drawer(
                backgroundColor: AppColor.hFFFFFF,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getIt.get<DrawerBloc>().add(ButtonProfileEvent());
                      },
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                          color: AppColor.hB9E3C6,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomImageCircle(
                                      imageUrl: user.photoUrl,
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
                                          Text(
                                            user.displayName ?? "",
                                            style: AppStyle.darkText(
                                              fontSize: Constants.titleFontSize,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Constants.size5,
                                          ),
                                          Text(
                                            user.email ?? "",
                                            style: AppStyle.lightDarkText(
                                              fontSize: Constants.smallFontSize,
                                            ).copyWith(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: Constants.maxLine,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                child: Image.asset(
                                  AppResource.close,
                                  color: AppColor.h686D76,
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
        return Container();
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
      title: Text(
        title ?? "",
        style: AppStyle.darkText(
          fontSize: Constants.subtitleFontSize,
        ),
      ),
      onTap: () {
        onTap;
        setState(() {});
      },
    );
  }
}
