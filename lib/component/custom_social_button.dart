import 'package:sport_app/resource/app_color.dart';
import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final String socialIconPath;
  final Color? iconColor;
  final Function() onTap;
  final Color? bgColor;
  final double? height;
  final double? width;
  const CustomSocialButton(
      {Key? key,
      required this.socialIconPath,
      required this.onTap,
      this.bgColor,
      this.iconColor,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.hDDDDDD),
              color: bgColor ?? Colors.transparent,
              shape: BoxShape.circle),
          child: Image.asset(
            socialIconPath,
            width: width ?? 30.0,
            height: height ?? 30.0,
            color: iconColor ?? AppColor.h413F42,
          )),
    );
  }
}
