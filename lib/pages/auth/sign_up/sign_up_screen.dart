import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/pages/base/base_screen.dart';
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

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.signUp,
        ),
        body: BlocBuilder<SignUpBloc, SignUpState>(
          bloc: getIt.get<SignUpBloc>(),
          builder: (_, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: Constants.size45),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: AppStrings.displayNameInput,
                        title: AppStrings.displayName,
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
                        title: AppStrings.email,
                        hintText: AppStrings.emailInput,
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
                        title: AppStrings.password,
                        isPassword: true,
                        hintText: AppStrings.passwordInput,
                        onChanged: (String password) =>
                            getIt.get<SignUpBloc>().add(
                                  GetUserEvent(
                                    password: password,
                                  ),
                                ),
                      ),
                      SizedBox(height: Constants.size30),
                      Button(
                        text: AppStrings.signUp,
                        onTap: () {
                          trySignUp();
                        },
                        textColor: AppColor.white,
                      ),
                      SizedBox(height: Constants.size30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void trySignUp() {
    if (_formKey.currentState!.validate()) {
      getIt.get<SignUpBloc>().add(CreateNewAccountEvent());
    } else {
      passwordController.clear();
    }
  }
}
