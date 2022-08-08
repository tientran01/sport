import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app/resource/resource.dart';

class TextView extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? lineNumber;
  final TextStyle? textStyle;
  const TextView({
    Key? key,
    this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.lineNumber,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: textStyle?.copyWith(
            fontSize: fontSize ?? Constants.size15,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? AppColor.black,
          ) ??
          GoogleFonts.nunito(
            fontSize: fontSize ?? Constants.size15,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? AppColor.black,
          ),
      overflow: TextOverflow.ellipsis,
      maxLines: lineNumber,
    );
  }
}
