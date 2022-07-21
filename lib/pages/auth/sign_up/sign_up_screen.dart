import 'package:sport_app/component/custom_button.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/sign_up/bloc/sign_up_bloc.dart';
import '../../../bloc/sign_up/bloc/sign_up_event.dart';
import '../../../bloc/sign_up/bloc/sign_up_state.dart';
import '../../../main.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.signUp,
                    style: AppStyle.header,
                  ),
                  SizedBox(height: Constants.size30),
                  CustomTextField(
                    type: TextFieldType.email,
                    title: AppStrings.email,
                    hintText: AppStrings.emailInput,
                    suffixIcon: const Icon(Icons.email),
                    onChanged: (String email) => getIt.get<SignUpBloc>().add(
                          GetEmailAndPasswordFormTextFieldEvent(email: email),
                        ),
                  ),
                  SizedBox(height: Constants.size10),
                  CustomTextField(
                    textEditingController: passwordController,
                    type: TextFieldType.password,
                    title: AppStrings.password,
                    hintText: AppStrings.usernameInput,
                    onChanged: (String password) => getIt.get<SignUpBloc>().add(
                          GetEmailAndPasswordFormTextFieldEvent(
                            password: password,
                          ),
                        ),
                  ),
                  SizedBox(height: Constants.size30),
                  CustomButton(
                    text: AppStrings.signUp,
                    onTap: () {
                      trySignUp();
                    },
                  ),
                  SizedBox(height: Constants.size30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.haveAccount,
                        style: AppStyle.lightTitle,
                      ),
                      GestureDetector(
                        onTap: () => NavigationService.navigatorKey.currentState
                            ?.pushNamed("/login"),
                        child: Text(
                          AppStrings.login,
                          style: AppStyle.title,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
