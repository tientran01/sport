import 'package:flutter/material.dart';
import 'package:sport_app/component/slide_route/slide_right_route.dart';
import 'package:sport_app/pages/category/category_screen.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class HeaderHome extends StatelessWidget implements PreferredSizeWidget {
  final int? notificationCount;
  final VoidCallback? onTap;
  const HeaderHome({
    Key? key,
    this.notificationCount,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: InkWell(
        child: Image.asset(
          AppResource.menu,
          width: Constants.size27,
        ),
        onTap: () {
          NavigationService.navigatorKey.currentState?.push(
            SlideRightRoute(
              page: const CategoryScreen(),
            ),
          );
        },
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
  Size get preferredSize => Size.fromHeight(Constants.size60);

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
              width: Constants.size27,
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
                      color: AppColor.arsenic,
                    ),
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: AppColor.white,
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
