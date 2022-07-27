import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

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
          width: Constants.sizeIcon,
        ),
        onTap: () {
          Scaffold.of(context).openDrawer();
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
