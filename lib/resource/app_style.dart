import 'package:sport_app/resource/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class AppStyle {
  static AppStyle appStyle = AppStyle._internal();
  AppStyle._internal();
  // static TextStyle header = const TextStyle(
  //   fontSize: 30.0,
  // );
  // static TextStyle title = const TextStyle(
  //   fontSize: 18.0,
  //   color: Colors.black,
  // );
  

  // static TextStyle lightTitle = title.copyWith(
  //   color: AppColor.h686D76,
  // );
  // static TextStyle carouselTitle = const TextStyle(
  //   fontSize: 22,
  //   color: AppColor.hFFFFFF,
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle price = GoogleFonts.lato(
  //   textStyle: const TextStyle(
  //     fontSize: 18.0,
  //     fontWeight: FontWeight.w900,
  //     color: AppColor.h413F42,
  //   ),
  // );
  // static TextStyle nameSection = GoogleFonts.lato(
  //   textStyle: const TextStyle(
  //     fontSize: 20.0,
  //     fontWeight: FontWeight.w800,
  //     color: AppColor.h413F42,
  //   ),
  // );
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: GoogleFonts.poppins(
      fontSize: 22,
      color: AppColor.h413F42,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(
        color: AppColor.h686D76,
      ),
    ),
  );


  static TextStyle darkText({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: AppColor.h000000,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w600
      )
    );
  }

  static TextStyle whiteText({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: AppColor.hFFFFFF,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w600
      )
    );
  }

  static TextStyle lightDarkText({double? fontSize}) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: AppColor.h686D76,
        fontSize: fontSize,
        fontWeight: FontWeight.w400
      )
    );
  }

  static TextStyle grayText({double? fontSize}) {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: AppColor.hDDDDDD,
        fontSize: fontSize,
        fontWeight: FontWeight.w400
      )
    );
  }
}
