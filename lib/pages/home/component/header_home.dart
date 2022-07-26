import 'package:flutter/material.dart';
import 'package:sport_app/component/component.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/pages/profile/profile_screen.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class HeaderHome extends StatelessWidget implements PreferredSizeWidget {
  const HeaderHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: Theme.of(context).backgroundColor,
      centerTitle: false,
      title: GestureDetector(
        child: TextView(
          text: S.of(context).hello,
          fontSize: Constants.size20,
          fontWeight: FontWeight.w900,
          textColor: AppColor.viridianGreen,
        ),
        onTap: () {
          NavigationService.navigatorKey.currentState?.push(
            SlideRightRoute(
              page: const ProfileScreen(),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.size60);
}
