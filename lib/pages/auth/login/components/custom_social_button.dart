import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class CustomSocialButton extends StatelessWidget {
  final String socialIconPath;
  final Color? iconColor;
  final Function() onTap;
  final Color? bgColor;
  const CustomSocialButton(
      {Key? key,
      required this.socialIconPath,
      required this.onTap,
      this.bgColor,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: bgColor ?? AppColor.darkSilver,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            socialIconPath,
            width: Constants.size30,
            height: Constants.size30,
            color: iconColor ?? AppColor.white,
          )),
    );
  }
}
