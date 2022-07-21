import 'package:flutter/material.dart';
import '../resource/resource.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? bgColor;
  final double? width;
  final double? height;
  const CustomButton({
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
          borderRadius: BorderRadius.circular(20.0),
          color: bgColor ?? AppColor.h413F42,
        ),
        alignment: Alignment.center,
        width: width ?? size.width,
        height: height ?? 56,
        child: Text(
          text.toUpperCase(),
          style: AppStyle.title.copyWith(
            color: AppColor.hFFFFFF,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final double? width;
  final double? height;
  const Button({
    Key? key,
    this.onPressed,
    required this.text,
    this.bgColor,
    this.width,
    this.height, this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(bgColor ?? AppColor.h000000),
      ),
      child: Container(
        padding: EdgeInsets.all(Constants.size20),
        child: Text(
          text,
          style: AppStyle.title.copyWith(color: textColor),
        ),
      ),
    );
  }
}
