import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/resource/resource.dart';

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
  final Widget? prefix;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function()? onTapSuffixIcon;
  final TextFieldType type;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;
  final bool? isPassword;
  final bool? isMaxLine;
  final int? maxLine;
  final Widget? counter;

  const CustomTextField({
    Key? key,
    this.title,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.type = TextFieldType.normal,
    this.onTapSuffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.textEditingController,
    this.isPassword,
    this.prefix,
    this.isMaxLine = false,
    this.maxLine,
    this.counter,
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
      maxLines: widget.maxLine ?? 1,
      controller: widget.textEditingController,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword == true ? !isHidden : isHidden,
      decoration: InputDecoration(
        counter: widget.counter,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Constants.size15,
          vertical: Constants.size20,
        ),
        label: TextView(
          text: widget.title,
          fontWeight: FontWeight.w600,
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefix,
        suffixIcon: widget.isPassword == true
            ? GestureDetector(
                onTap: widget.onTapSuffixIcon ?? changeSuffixIcon,
                child: suffixIconPassword(),
              )
            : widget.suffixIcon,
        border: outlineInputBorder(color: Colors.transparent),
        focusedBorder: outlineInputBorder(color: AppColor.arsenic),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validatorText,
    );
  }

  void changeSuffixIcon() {
    setState(
      () => isHidden = !isHidden,
    );
  }

  Widget suffixIconPassword() {
    if (type == TextFieldType.password) {
      if (isHidden) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: Constants.size25),
          child: Image.asset(
            AppResource.eye,
            width: Constants.size20,
            height: Constants.size20,
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: Constants.size25),
          child: Image.asset(
            AppResource.invisible,
            width: Constants.size20,
            height: Constants.size20,
          ),
        );
      }
    }
    return Container();
  }

  String? validatorText(String? value) {
    AppLocalizations local = AppLocalizations.of(context);
    switch (widget.type) {
      case TextFieldType.email:
        if (value == null || value.isEmpty) {
          return local.required;
        } else if (!isEmailValid(value)) {
          return local.emailInvalid;
        }
        break;
      case TextFieldType.password:
        if (value == null || value.isEmpty) {
          return local.required;
        } else if (!isPasswordValid(value)) {
          return local.passwordInvalid;
        }
        break;
      case TextFieldType.normal:
        if (value == null || value.isEmpty) {
          return local.required;
        }
        break;
      case TextFieldType.phoneNumber:
        if (value == null || value.isEmpty) {
          return local.required;
        } else if (!isPhoneValid(value)) {
          return local.phoneInvalid;
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
      borderSide: BorderSide(
        color: color ?? AppColor.darkSilver,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(
        Constants.size5,
      ),
    );
  }
}
