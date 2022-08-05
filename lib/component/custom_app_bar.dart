import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/app_resource.dart';
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
      title: TextView(
        text: title ?? "",
        fontSize: Constants.size17,
      ),
      leading: onPressedLeft != null
          ? IconButton(
              onPressed: onPressedLeft,
              icon: Image.asset(
                leadingIconPath ?? AppResource.leftArrow,
                width: Constants.size27,
                height: Constants.size27,
              ),
            )
          : Container(),
      actions: [
        rightIconPath != null
            ? IconButton(
                onPressed: onPressedRight,
                icon: Image.asset(
                  rightIconPath ?? "",
                  width: Constants.size27,
                ),
              )
            : Container()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.size60);
}
