import 'package:flutter/material.dart';
import 'package:sport_app/component/slide_route/slide_right_route.dart';
import 'package:sport_app/component/text_view.dart';
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
          text: AppStrings.hello,
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
      actions: [
        IconButton(
            onPressed: () {
              NavigationService.navigatorKey.currentState
                  ?.pushNamed(AppRouteName.search);
            },
            icon: Image.asset(
              AppResource.search,
              width: Constants.size25,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.size60);
}
