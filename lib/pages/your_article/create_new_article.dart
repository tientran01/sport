import 'package:flutter/material.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/component/component.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/pages/base/base_view.dart';
import 'package:sport_app/permission/open_image_picker.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class CreateNewArticle extends StatefulWidget {
  final VoidCallback? onTap;
  const CreateNewArticle({Key? key, this.onTap}) : super(key: key);

  @override
  State<CreateNewArticle> createState() => _CreateNewArticleState();
}

class _CreateNewArticleState extends State<CreateNewArticle> with BaseView {
  String? imagePath;
  YourArticle yourArticle = YourArticle(
    publishedAt: DateTime.now().toString(),
    author: FirebaseHelper.shared.auth.currentUser?.email,
  );

  @override
  String? get titleAppBar => S.of(context).createNewArticle;
  @override
  bool? get isPop => true;
  @override
  Widget get body {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.size20,
          vertical: Constants.size25,
        ),
        child: Form(
          key: super.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                title: S.of(context).title,
                hintText: S.of(context).titleInput,
                maxLine: 3,
                onChanged: (String title) {
                  yourArticle.title = title;
                },
              ),
              SizedBox(
                height: Constants.size25,
              ),
              CustomTextField(
                title: S.of(context).description,
                hintText: S.of(context).descriptionInput,
                maxLine: 5,
                onChanged: (String describe) {
                  yourArticle.describe = describe;
                },
              ),
              SizedBox(
                height: Constants.size25,
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    height: Constants.size150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.darkSilver,
                      ),
                      borderRadius: BorderRadius.circular(Constants.size10),
                    ),
                    child: imagePath == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showActionImage();
                                },
                                child: Image.asset(
                                  AppResource.camera,
                                  width: Constants.size40,
                                  color: AppColor.darkSilver,
                                ),
                              ),
                              SizedBox(
                                height: Constants.size5,
                              ),
                              TextView(
                                text: S.of(context).uploadImage,
                                textColor: AppColor.darkSilver,
                              ),
                            ],
                          )
                        : ImageLocal(
                            imagePath: imagePath,
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: Constants.size20,
              ),
              Button(
                bgColor: AppColor.viridianGreen,
                text: S.of(context).post,
                textColor: AppColor.white,
                onTap: () {
                  if (super.formKey.currentState!.validate()) {
                    getIt.get<YourArticleBloc>().add(
                        CreateNewYourArticleEvent(yourArticle: yourArticle));
                  } else {
                    super.showSnackBar(S.of(context).createYourArticleError);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showActionImage() {
    ActionComponent.shared.showActionUploadImage(
      context: context,
      onCamera: () {
        OpenImagePicker.getImage(
          getImageFromCamera: true,
          value: (String image) {
            setState(
              () {
                imagePath = image;
              },
            );
            yourArticle.urlToImage = imagePath;
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
            yourArticle.urlToImage = imagePath;
          },
        );
      },
    );
  }
}
