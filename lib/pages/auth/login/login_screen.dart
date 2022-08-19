import 'package:sport_app/bloc/login/bloc/login_event.dart';
import 'package:sport_app/bloc/login/bloc/login_bloc.dart';
import 'package:sport_app/bloc/login/bloc/login_state.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/pages/auth/login/components/divider_custom.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/base/base_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/custom_social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BaseView {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  String? get titleAppBar => AppStrings.login;
  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: getIt.get<LoginBloc>(),
      builder: (_, state) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: super.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Constants.size30),
                    CustomTextField(
                      textEditingController: emailController,
                      type: TextFieldType.email,
                      title: local.email,
                      hintText: local.emailInput,
                      onChanged: (email) => getIt.get<LoginBloc>().add(
                            GetEmailAndPasswordFormTextFieldEvent(
                              email: email,
                            ),
                          ),
                    ),
                    SizedBox(height: Constants.size30),
                    CustomTextField(
                      textEditingController: passwordController,
                      title: local.password,
                      type: TextFieldType.password,
                      hintText: local.passwordInput,
                      isPassword: true,
                      onChanged: (String password) {
                        getIt.get<LoginBloc>().add(
                              SignInWithFacebookEvent(),
                            );
                      },
                    ),
                    buildForgetPassword(),
                    SizedBox(height: Constants.size30),
                    Button(
                      text: AppStrings.login,
                      onTap: () {
                        if (state.isValid) {
                          getIt
                              .get<LoginBloc>()
                              .add(LoginWithEmailAndPasswordEvent());
                        } else {
                          showSnackBar(AppStrings.loginFail);
                        }
                      },
                      textColor: AppColor.white,
                    ),
                    SizedBox(height: Constants.size30),
                    const DividerCustom(
                      textDisplay: AppStrings.or,
                    ),
                    SizedBox(height: Constants.size30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSocialButton(
                          socialIconPath: AppResource.phoneIcon,
                          bgColor: AppColor.jetStream,
                          onTap: () {
                            NavigationService.navigatorKey.currentState
                                ?.pushNamed(
                              AppRouteName.phoneInput,
                            );
                          },
                        ),
                        SizedBox(width: Constants.size10),
                        CustomSocialButton(
                          socialIconPath: AppResource.facebookIcon,
                          bgColor: AppColor.blue,
                          onTap: () {
                            getIt.get<LoginBloc>().add(
                                  SignInWithFacebookEvent(),
                                );
                          },
                        ),
                        SizedBox(width: Constants.size10),
                        CustomSocialButton(
                          socialIconPath: AppResource.googleIcon,
                          bgColor: AppColor.gargoyleGas,
                          onTap: () {
                            getIt.get<LoginBloc>().add(
                                  SignInWithGoogleEvent(),
                                );
                          },
                        ),
                        SizedBox(width: Constants.size10),
                        SizedBox(height: Constants.size30),
                        CustomTextField(
                          textEditingController: emailController,
                          type: TextFieldType.email,
                          title: local.email,
                          hintText: local.emailInput,
                          onChanged: (email) => getIt.get<LoginBloc>().add(
                                GetEmailAndPasswordFormTextFieldEvent(
                                  email: email,
                                ),
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: Constants.size30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextView(
                          text: AppStrings.noAccount,
                          textColor: AppColor.gainsboro,
                        ),
                        SizedBox(
                          width: Constants.size5,
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationService.navigatorKey.currentState
                                ?.pushNamed(AppRouteName.signUp);
                          },
                          child: const TextView(
                            text: AppStrings.signUp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
        margin: EdgeInsets.only(
          top: Constants.size10,
          right: Constants.size10,
        ),
        alignment: Alignment.bottomRight,
        child: const TextView(
          text: AppStrings.forgetPassword,
          textColor: AppColor.gainsboro,
        ),
      ),
    );
  }
}
