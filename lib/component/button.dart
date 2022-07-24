import 'package:flutter/material.dart';
import '../resource/resource.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? bgColor;
  final double? width;
  final double? height;
  const Button({
    Key? key,
    this.onTap,
    required this.text,
    this.bgColor,
    this.width,
    this.height,
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
          color: bgColor ?? AppColor.h413F42,
        ),
        alignment: Alignment.center,
        width: width ?? size.width,
        height: height ?? Constants.heightButton,
        child: Text(
          text.toUpperCase(),
          style: AppStyle.whiteText(
            fontSize: Constants.subtitleFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
