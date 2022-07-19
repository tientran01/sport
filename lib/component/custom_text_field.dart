import 'package:sport_app/resource/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resource/app_strings.dart';

enum TextFieldType {
  email,
  password,
  normal,
  phoneNumber,
}

class CustomTextField extends StatefulWidget {
  final String? title;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function()? onTapSuffixIcon;
  final TextFieldType type;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;

  const CustomTextField({
    Key? key,
    this.title,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.type = TextFieldType.normal,
    this.onTapSuffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextFieldType? type;
  bool isHidden = false;
  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      keyboardType: widget.keyboardType,
      obscureText: isHidden,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        labelText: widget.title,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            GestureDetector(
              onTap: widget.onTapSuffixIcon ?? changeSuffixIcon,
              child: suffixIconPassword(),
            ),
        border: outlineInputBorder(color: Colors.transparent),
        focusedBorder: outlineInputBorder(color: AppColor.h413F42),
      ),
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validatorText,
    );
  }

  void changeSuffixIcon() {
    setState(() => isHidden = !isHidden);
  }

  Widget suffixIconPassword() {
    if (type == TextFieldType.password) {
      if (isHidden) {
        return const Icon(Icons.visibility_off_rounded);
      } else {
        return const Icon(Icons.remove_red_eye);
      }
    }
    return Container();
  }

  String? validatorText(String? value) {
    switch (widget.type) {
      case TextFieldType.email:
        if (value == null || value.isEmpty) {
          return AppStrings.required;
        } else if (!isEmailValid(value)) {
          return AppStrings.emailInvalid;
        }
        break;
      case TextFieldType.password:
        if (value == null || value.isEmpty) {
          return AppStrings.required;
        } else if (!isPasswordValid(value)) {
          return AppStrings.passwordInvalid;
        }
        break;
      case TextFieldType.normal:
        break;
      case TextFieldType.phoneNumber:
        if (value == null || value.isEmpty) {
          return AppStrings.required;
        } else if (!isPhoneValid(value)) {
          return AppStrings.phoneInvalid;
        }
        break;
    }
    return null;
  }

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*\d).{8,15}$',
    );
    return passwordRegExp.hasMatch(password);
  }

  bool isPhoneValid(String phone) {
    final RegExp phoneRegExp = RegExp(
      r'(^(?:[+0]9)?[0-9]{9,10}$)',
    );
    return phoneRegExp.hasMatch(phone);
  }

  OutlineInputBorder outlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide:
          BorderSide(color: color ?? AppColor.borderOTPColor, width: 1.0),
      borderRadius: BorderRadius.circular(20.0),
    );
  }
}
