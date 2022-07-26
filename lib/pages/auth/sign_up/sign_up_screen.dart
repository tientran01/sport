import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/pages/base/base_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/sign_up/bloc/sign_up_bloc.dart';
import '../../../bloc/sign_up/bloc/sign_up_event.dart';
import '../../../bloc/sign_up/bloc/sign_up_state.dart';
import '../../../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with BaseView {
  final TextEditingController passwordController = TextEditingController();
  @override
  String? get titleAppBar => S.of(context).signup;
  @override
  Widget get body {
    return BlocBuilder<SignUpBloc, SignUpState>(
      bloc: getIt.get<SignUpBloc>(),
      builder: (_, state) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(top: Constants.size45),
            child: Form(
                key: super.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: S.of(context).displayNameInput,
                      title: S.of(context).displayName,
                      type: TextFieldType.normal,
                      onChanged: (String displayName) {
                        getIt.get<SignUpBloc>().add(
                              GetUserEvent(
                                displayName: displayName,
                              ),
                            );
                      },
                    ),
                    SizedBox(height: Constants.size30),
                    CustomTextField(
                      type: TextFieldType.email,
                      title: S.of(context).email,
                      hintText: S.of(context).emailInput,
                      onChanged: (String email) {
                        getIt.get<SignUpBloc>().add(
                              GetUserEvent(
                                email: email,
                              ),
                            );
                      },
                    ),
                    SizedBox(height: Constants.size30),
                    CustomTextField(
                      textEditingController: passwordController,
                      type: TextFieldType.password,
                      title: S.of(context).password,
                      isPassword: true,
                      hintText: S.of(context).passwordInput,
                      onChanged: (String password) =>
                          getIt.get<SignUpBloc>().add(
                                GetUserEvent(
                                  password: password,
                                ),
                              ),
                    ),
                    SizedBox(height: Constants.size30),
                    Button(
                      text: S.of(context).signup,
                      onTap: () {
                        trySignUp();
                      },
                      textColor: AppColor.white,
                      bgColor: AppColor.viridianGreen,
                    ),
                    SizedBox(height: Constants.size30),
                  ],
                )),
          ),
        );
      },
    );
  }

  void trySignUp() {
    if (super.formKey.currentState?.validate() == true) {
      getIt.get<SignUpBloc>().add(CreateNewAccountEvent());
      super.unfocus(context);
    } else {
      showSnackBar(AppStrings.error);
    }
  }
}
