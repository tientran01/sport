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
