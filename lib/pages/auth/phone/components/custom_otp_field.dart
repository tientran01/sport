import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sport_app/resource/resource.dart';

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
      defaultPinTheme: PinTheme(
        width: Constants.size60,
        height: Constants.size60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.size15),
          border: Border.all(
            color: AppColor.darkSilver,
          ),
        ),
        textStyle: TextStyle(
          fontSize: Constants.size20,
          fontWeight: FontWeight.bold,
        ),
      ),
      length: 6,
      onChanged: onChanged,
      controller: textEditingController,
    );
  }
}
