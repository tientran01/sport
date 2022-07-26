import 'package:sport_app/bloc/login/bloc/login_event.dart';
import 'package:sport_app/bloc/login/bloc/login_bloc.dart';
import 'package:sport_app/bloc/login/bloc/login_state.dart';
import 'package:sport_app/component/component.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/pages/auth/login/components/divider_custom.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/base/base_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BaseView {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  String? get titleAppBar => S.of(context).signin;
  @override
  Widget get body {
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
                      title: S.of(context).email,
                      hintText: S.of(context).emailInput,
                      onChanged: (email) => getIt.get<LoginBloc>().add(
                            GetEmailAndPasswordFormTextFieldEvent(
                              email: email,
                            ),
                          ),
                    ),
                    SizedBox(height: Constants.size30),
                    CustomTextField(
                      textEditingController: passwordController,
                      title: S.of(context).password,
                      type: TextFieldType.password,
                      hintText: S.of(context).passwordInput,
                      isPassword: true,
                      onChanged: (String password) {
                        getIt.get<LoginBloc>().add(
                              GetEmailAndPasswordFormTextFieldEvent(
                                password: password,
                              ),
                            );
                      },
                    ),
                    
                    SizedBox(height: Constants.size30),
                    Button(
                      text: S.of(context).signin,
                      onTap: () {
                        tryLogin();
                      },
                      textColor: AppColor.white,
                      bgColor: AppColor.viridianGreen,
                    ),
                    SizedBox(height: Constants.size30),
                    DividerCustom(
                      textDisplay: S.of(context).or,
                    ),
                    SizedBox(height: Constants.size30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          socialIconPath: AppResource.facebookIcon,
                          bgColor: AppColor.blue,
                          onTap: () {
                            getIt.get<LoginBloc>().add(
                                  SignInWithFacebookEvent(),
                                );
                          },
                        ),
                        SizedBox(width: Constants.size10),
                        SocialButton(
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
                          text: S.of(context).noAccount,
                          textColor: AppColor.gainsboro,
                        ),
                        SizedBox(
                          width: Constants.size5,
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationService.navigatorKey.currentState
                                ?.pushNamed(
                              AppRouteName.signUp,
                            );
                          },
                          child: TextView(
                            text: S.of(context).signup,
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

  void tryLogin() {
    if (super.formKey.currentState?.validate() == true) {
      getIt.get<LoginBloc>().add(LoginWithEmailAndPasswordEvent());
      super.unfocus(context);
    } else {
      super.showSnackBar(AppStrings.error);
    }
  }
}
