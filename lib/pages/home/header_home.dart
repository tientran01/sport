import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_resource.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/router/navigation_service.dart';

class HeaderHome extends StatelessWidget implements PreferredSizeWidget {
  final String? displayName;
  final String? email;
  final VoidCallback? onTap;
  final int? notificationCount;
  const HeaderHome({
    Key? key,
    this.displayName,
    this.email,
    this.onTap,
    this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: InkWell(
        onTap: () => NavigationService.navigatorKey.currentState
            ?.pushNamed(AppRouteName.profile),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDisplayName(displayName: displayName),
            buildEmail(email: email),
          ],
        ),
      ),
      actions: [
        buildNotification(
          onTap: onTap,
          notificationCount: notificationCount,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.heightAppBar);

  Widget buildDisplayName({String? displayName}) {
    if (displayName != null) {
      return Text(
        "Hello $displayName",
        style: AppStyle.darkText(),
      );
    }
    return Text(
      "Hello",
      style: AppStyle.darkText(),
    );
  }

  Widget buildEmail({String? email}) {
    return Text(
      email ?? "",
      style: AppStyle.lightDarkText(),
    );
  }

  Widget buildNotification({
    VoidCallback? onTap,
    int? notificationCount,
  }) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(Constants.size10),
            child: Image.asset(
              AppResource.notification,
              width: Constants.sizeIcon,
            ),
          ),
          notificationCount != 0
              ? Positioned(
                  top: 0,
                  right: 1,
                  child: Container(
                    padding: EdgeInsets.all(Constants.size5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.h413F42,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: AppColor.hFFFFFF,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
