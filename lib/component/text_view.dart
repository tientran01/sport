import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app/resource/resource.dart';

class TextView extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isMaxLine;
  final int? lineNumber;
  const TextView({
    Key? key,
    this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.isMaxLine = false,
    this.lineNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: GoogleFonts.nunito(
        fontSize: fontSize ?? Constants.size15,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: textColor ?? AppColor.black,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: isMaxLine == true ? lineNumber : 1,
    );
  }
}
