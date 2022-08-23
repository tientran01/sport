import 'package:sport_app/bloc/foget_password/bloc/forget_password_bloc.dart';
import 'package:sport_app/bloc/foget_password/bloc/forget_password_event.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/resource/resource.dart';
import '../../../bloc/foget_password/bloc/forget_password_state.dart';

class InputEmailResetScreen extends StatelessWidget {
  const InputEmailResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: local.forgetPassword,
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
                CustomTextField(
                  type: TextFieldType.email,
                  title: local.email,
                  hintText: local.emailInput,
                  suffixIcon: const Icon(Icons.email),
                  onChanged: (String email) {
                    getIt.get<ForgetPasswordBloc>().add(
                          GetEmailAndCheckValidEvent(email: email),
                        );
                  },
                ),
                SizedBox(height: Constants.size30),
                Button(
                  text: local.send,
                  textColor: AppColor.white,
                  onTap: () => getIt.get<ForgetPasswordBloc>().add(
                        SendEmailEvent(),
                      ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
