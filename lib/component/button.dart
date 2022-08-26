import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import '../resource/resource.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? textColor;
  final Color? bgColor;
  final double? width;
  final double? height;
  const Button({
    Key? key,
    this.onTap,
    required this.text,
    this.bgColor,
    this.width,
    this.height, this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(Constants.size5),
            color: bgColor ?? AppColor.arsenic,
          ),
          alignment: Alignment.center,
          width: width ?? size.width,
          height: height ?? Constants.heightButton,
          child: TextView(
            text: text.toUpperCase(),
            fontWeight: FontWeight.w700,
            textColor: textColor,
          )),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String socialIconPath;
  final Color? iconColor;
  final Function() onTap;
  final Color? bgColor;
  const SocialButton(
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