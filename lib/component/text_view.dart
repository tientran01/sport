import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app/resource/resource.dart';

class TextView extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const TextView(
      {Key? key, this.text, this.textColor, this.fontSize, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: GoogleFonts.lato(
        fontSize: fontSize ?? Constants.subtitleFontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: textColor ?? AppColor.black,
      ),
    );
  }
}
