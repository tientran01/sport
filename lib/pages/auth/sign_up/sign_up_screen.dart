import 'package:sport_app/component/action.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/permission/open_image_picker.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
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
  String? imagePath;

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.signUp,
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (_, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.only(top: Constants.size45),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageCircle(
                      width: Constants.size100,
                      height: Constants.size100,
                      iconPath: AppResource.camera,
                      imageUrl: imagePath,
                      onTap: () {
                        showActionUploadImage(context);
                      },
                    ),
                    SizedBox(height: Constants.size30),
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
                      onChanged: (String email) => getIt.get<SignUpBloc>().add(
                            GetUserEvent(email: email),
                          ),
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
    );
  }

  void trySignUp() {
    if (_formKey.currentState!.validate()) {
      getIt.get<SignUpBloc>().add(CreateNewAccountEvent());
    } else {
      passwordController.clear();
    }
  }

  void showActionUploadImage(BuildContext context) {
    ActionComponent.shared.showActionUploadImage(
      context: context,
      onCamera: () {
        OpenImagePicker.getImage(
          getImageFromCamera: true,
          value: (String image) {
            setState(
              () {
                imagePath = image;
                NavigationService.navigatorKey.currentState?.pop();
                FirebaseHelper.shared.uploadImageUser(imagePath: imagePath);
              },
            );
          },
        );
      },
      onGalley: () {
        OpenImagePicker.getImage(
          getImageFromCamera: false,
          value: (String image) {
            setState(
              () {
                imagePath = image;
                NavigationService.navigatorKey.currentState?.pop();
              },
            );
          },
        );
      },
    );
  }
}
