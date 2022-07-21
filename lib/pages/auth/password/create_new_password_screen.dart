import 'package:sport_app/bloc/foget_password/bloc/forget_password_bloc.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/resource/resource.dart';
import '../../../bloc/foget_password/bloc/forget_password_state.dart';
import '../../../component/custom_button.dart';
import '../../../component/custom_text_field.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIconPath: AppResource.leftArrow,
      ),
      body: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    AppStrings.createNewPassword,
                    style: AppStyle.header.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: Constants.size30),
                const CustomTextField(
                  type: TextFieldType.password,
                  title: AppStrings.password,
                  hintText: AppStrings.passwordInput,
                ),
                SizedBox(height: Constants.size10),
                const CustomTextField(
                  type: TextFieldType.password,
                  title: AppStrings.confirmPassword,
                  hintText: AppStrings.confirmPassword,
                ),
                SizedBox(height: Constants.size30),
                const CustomButton(
                  text: AppStrings.resetPassword,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
