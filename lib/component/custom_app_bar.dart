import 'package:sport_app/component/text_view.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? leadingIconPath;
  final VoidCallback? onPressedLeft;
  final VoidCallback? onPressedRight;
  final Color? leftIconColor;
  final String? title;
  final String? rightIconPath;
  final Color? titleColor;
  final Color? bgColor;
  const CustomAppBar({
    Key? key,
    this.leadingIconPath,
    this.title,
    this.rightIconPath,
    this.onPressedLeft,
    this.onPressedRight,
    this.leftIconColor,
    this.titleColor, this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: bgColor ?? Theme.of(context).backgroundColor,
      title: TextView(
        text: title ?? "",
        fontSize: Constants.size17,
        textColor: titleColor ?? AppColor.black,
      ),
      leading: onPressedLeft != null
          ? IconButton(
              onPressed: onPressedLeft,
              icon: Image.asset(
                leadingIconPath ?? AppResource.leftArrow,
                width: Constants.size27,
                height: Constants.size27,
                color: leftIconColor ?? AppColor.black,
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
