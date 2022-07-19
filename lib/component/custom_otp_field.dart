import 'package:sport_app/resource/app_style.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomOTPField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  const CustomOTPField({
    Key? key,
    this.onChanged,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinput(
      defaultPinTheme: AppStyle.appStyle.defaultPinTheme,
      length: 6,
      onChanged: onChanged,
      controller: textEditingController,
    );
  }
}
