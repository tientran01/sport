import 'package:sport_app/bloc/foget_password/bloc/forget_password_bloc.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/resource/resource.dart';
import '../../../bloc/foget_password/bloc/forget_password_state.dart';
import '../../../component/button.dart';
import '../../../component/custom_text_field.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        leadingIconPath: AppResource.leftArrow,
      ),
      body: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
        builder: (_, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.size20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TextView(
                    text: AppStrings.createNewPassword,
                    fontSize: Constants.size25,
                  ),
                ),
                SizedBox(height: Constants.size30),
                CustomTextField(
                  type: TextFieldType.password,
                  title: local.password,
                  hintText: local.passwordInput,
                ),
                SizedBox(height: Constants.size10),
                const CustomTextField(
                  type: TextFieldType.password,
                  title: AppStrings.confirmPassword,
                  hintText: AppStrings.confirmPassword,
                ),
                SizedBox(height: Constants.size30),
                const Button(
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
