import 'package:sport_app/resource/app_resource.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? leadingIconPath;
  final VoidCallback? onPressedLeft;
  final VoidCallback? onPressedRight;
  final String? title;
  final String? rightIconPath;
  const CustomAppBar({
    Key? key,
    this.leadingIconPath,
    this.title,
    this.rightIconPath,
    this.onPressedLeft,
    this.onPressedRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(
        title ?? "",
        style: AppStyle.title,
      ),
      leading: IconButton(
        onPressed: onPressedLeft,
        icon: Image.asset(leadingIconPath ?? AppResource.leftArrow),
      ),
      actions: [
        rightIconPath != null
            ? IconButton(
                onPressed: () {},
                icon: Image.asset(rightIconPath ?? ""),
              )
            : Container()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.heightAppBar);
}
