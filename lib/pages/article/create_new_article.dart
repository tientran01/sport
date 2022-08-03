import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/component/action.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/helper/firebase_helper.dart';
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
        return Scaffold(
          appBar: CustomAppBar(
            title: AppStrings.createNewArticle,
            onPressedLeft: () {
              NavigationService.navigatorKey.currentState?.pop();
            },
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
                      setState(() {
                        yourArticle?.title = title;
                      });
                      getIt.get<YourArticleBloc>().add(
                            GetYourArticleEvent(
                              yourArticle: yourArticle,
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
                      setState(() {
                        yourArticle?.description = description;
                      });

                      getIt.get<YourArticleBloc>().add(
                            GetYourArticleEvent(
                              yourArticle: yourArticle,
                            ),
                          );
                    },
                  ),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  TextView(
                    text: AppStrings.uploadImage,
                    fontSize: Constants.size17,
                  ),
                  SizedBox(
                    height: Constants.size10,
                  ),
                  imagePath == "" && imagePath.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            _uploadImage();
                          },
                          child: DottedBorder(
                            radius: Radius.circular(Constants.size10),
                            color: AppColor.gainsboro,
                            child: Container(
                              width: Constants.size150,
                              height: Constants.size100,
                              padding: EdgeInsets.symmetric(
                                horizontal: Constants.size20,
                                vertical: Constants.size15,
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    AppResource.camera,
                                    width: Constants.size27,
                                  ),
                                  SizedBox(
                                    height: Constants.size10,
                                  ),
                                  const TextView(
                                    text: AppStrings.uploadImage,
                                    textColor: AppColor.darkSilver,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : CustomImage(
                          imageUrl: imagePath,
                          width: Constants.size150,
                          height: Constants.size100,
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
                          .add(CreateNewYourArticleEvent(yourArticle: yourArticle));
                    },
                  )
                ],
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
              FirebaseHelper.shared.getImage(
                imagePath: imagePath,
              );
              NavigationService.navigatorKey.currentState?.pop();
            });
          },
        );
      },
    );
  }
}
