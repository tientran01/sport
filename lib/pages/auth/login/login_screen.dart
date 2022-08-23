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
  String? get titleAppBar => AppLocalizations.of(context).signin;
  @override
  Widget get body {
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
                              GetEmailAndPasswordFormTextFieldEvent(
                                password: password,
                              ),
                            );
                      },
                    ),
                    buildForgetPassword(local.forgetPassword),
                    SizedBox(height: Constants.size30),
                    Button(
                        text: local.signin,
                        onTap: () {
                          tryLogin();
                        },
                        textColor: AppColor.white,
                        bgColor: AppColor.viridianGreen),
                    SizedBox(height: Constants.size30),
                    DividerCustom(
                      textDisplay: local.or,
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
                                ?.pushNamed(AppRouteName.phoneInput);
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
                      ],
                    ),
                    SizedBox(height: Constants.size30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          text: local.noAccount,
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
                          child: TextView(
                            text: local.signup,
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

  Widget buildForgetPassword(String text) {
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
        child: TextView(
          text: text,
          textColor: AppColor.gainsboro,
        ),
      ),
    );
  }

  void tryLogin() {
    if (super.formKey.currentState?.validate() == true) {
      getIt.get<LoginBloc>().add(LoginWithEmailAndPasswordEvent());
    } else {
      super.showSnackBar(AppStrings.error);
    }
  }
}
