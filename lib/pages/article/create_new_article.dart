import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/component/action.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/permission/open_image_picker.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class CreateNewArticle extends StatefulWidget {
  final VoidCallback? onTap;
  const CreateNewArticle({Key? key, this.onTap}) : super(key: key);

  @override
  State<CreateNewArticle> createState() => _CreateNewArticleState();
}

class _CreateNewArticleState extends State<CreateNewArticle> {
  String imagePath = "";
  YourArticle? yourArticle = YourArticle(
    publishedAt: DateTime.now().toString(),
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YourArticleBloc, YourArticleState>(
      bloc: getIt.get<YourArticleBloc>(),
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: Scaffold(
            appBar: const CustomAppBar(
              title: AppStrings.createNewArticle,
              
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.size30,
                  vertical: Constants.size45,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      title: AppStrings.titleArticle,
                      hintText: AppStrings.titleArticleInput,
                      onChanged: (String title) {
                        getIt.get<YourArticleBloc>().add(
                              GetArticleFromTextFieldEvent(
                                title: title,
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: Constants.size25,
                    ),
                    CustomTextField(
                      title: AppStrings.descArticle,
                      hintText: AppStrings.descArticleInput,
                      isMaxLine: true,
                      maxLine: 5,
                      onChanged: (String description) {
                        getIt.get<YourArticleBloc>().add(
                              GetArticleFromTextFieldEvent(
                                description: description,
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: Constants.size20,
                    ),
                    Button(
                      bgColor: AppColor.black,
                      text: AppStrings.postArticle,
                      textColor: AppColor.white,
                      onTap: () {
                        getIt
                            .get<YourArticleBloc>()
                            .add(CreateNewYourArticleEvent());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _uploadImage() {
    ActionComponent.shared.showActionUploadImage(
      context: context,
      onCamera: () {
        OpenImagePicker.getImage(
          getImageFromCamera: true,
          value: (String image) {
            setState(() {
              imagePath = image;
            });
          },
        );
      },
      onGalley: () {
        OpenImagePicker.getImage(
          getImageFromCamera: false,
          value: (String image) {
            setState(() {
              imagePath = image;
              NavigationService.navigatorKey.currentState?.pop();
            });
          },
        );
      },
    );
  }
}
