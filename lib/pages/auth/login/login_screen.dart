import 'package:sport_app/bloc/login/bloc/login_event.dart';
import 'package:sport_app/bloc/login/bloc/login_bloc.dart';
import 'package:sport_app/bloc/login/bloc/login_state.dart';
import 'package:sport_app/component/custom_button.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../component/custom_divider.dart';
import '../../../component/custom_social_button.dart';
import '../../../resource/app_resource.dart';
import '../../../resource/app_route_name.dart';
import '../../../resource/app_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (_, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Constants.size30),
                      const Text(
                        AppStrings.login,
                        style: TextStyle(fontSize: 25.0, color: Colors.black),
                      ),
                      SizedBox(height: Constants.size30),
                      CustomTextField(
                        textEditingController: emailController,
                        type: TextFieldType.email,
                        title: AppStrings.email,
                        hintText: AppStrings.emailInput,
                        suffixIcon: const Icon(Icons.email),
                        onChanged: (email) => getIt.get<LoginBloc>().add(
                              GetEmailAndPasswordFormTextFieldEvent(
                                  email: email),
                            ),
                      ),
                      SizedBox(height: Constants.size10),
                      CustomTextField(
                        textEditingController: passwordController,
                        title: AppStrings.password,
                        type: TextFieldType.password,
                        hintText: AppStrings.passwordInput,
                        onChanged: (String password) =>
                            getIt.get<LoginBloc>().add(
                                  GetEmailAndPasswordFormTextFieldEvent(
                                      password: password),
                                ),
                      ),
                      buildForgetPassword(),
                      SizedBox(height: Constants.size30),
                      CustomButton(
                        text: AppStrings.login,
                        onTap: () {
                          tryLogin();
                        },
                      ),
                      SizedBox(height: Constants.size30),
                      const CustomDivider(
                        textDisplay: AppStrings.or,
                        isOr: true,
                      ),
                      SizedBox(height: Constants.size30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSocialButton(
                            socialIconPath: AppResource.phoneIcon,
                            onTap: () => getIt
                                .get<LoginBloc>()
                                .add(SignInWithPhoneNumberEvent()),
                          ),
                          SizedBox(width: Constants.size10),
                          CustomSocialButton(
                            socialIconPath: AppResource.facebookIcon,
                            onTap: () => getIt.get<LoginBloc>().add(
                                  SignInWithFacebookEvent(),
                                ),
                          ),
                          SizedBox(width: Constants.size10),
                          CustomSocialButton(
                            socialIconPath: AppResource.googleIcon,
                            onTap: () => getIt.get<LoginBloc>().add(
                                  SignInWithGoogleEvent(),
                                ),
                          ),
                          SizedBox(width: Constants.size10),
                        ],
                      ),
                      SizedBox(height: Constants.size30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.noAccount,
                            style: AppStyle.lightTitle,
                          ),
                          GestureDetector(
                            onTap: () =>
                                getIt.get<LoginBloc>().add(SignUpEvent()),
                            child: Text(
                              AppStrings.signUp,
                              style: AppStyle.title,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //test01@gmail.com - 123456789
  void tryLogin() {
    if (_formKey.currentState!.validate()) {
      getIt.get<LoginBloc>().add(LoginWithFirebaseEvent());
    } else {
      showSnackBar(AppStrings.loginFail);
      passwordController.clear();
    }
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForgetPassword() {
    return GestureDetector(
      onTap: () => NavigationService.navigatorKey.currentState?.pushNamed(
        AppRouteName.inputEmailReset,
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, right: 10.0),
        alignment: Alignment.bottomRight,
        child: Text(
          AppStrings.forgetPassword,
          style: AppStyle.title.copyWith(
            fontSize: 16,
            decoration: TextDecoration.underline,
            color: AppColor.borderOTPColor,
          ),
        ),
      ),
    );
  }
}
