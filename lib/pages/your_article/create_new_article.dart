import 'package:flutter/material.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/pages/base/base_screen.dart';
import 'package:sport_app/resource/resource.dart';

class CreateNewArticle extends StatefulWidget {
  final VoidCallback? onTap;
  const CreateNewArticle({Key? key, this.onTap}) : super(key: key);

  @override
  State<CreateNewArticle> createState() => _CreateNewArticleState();
}

class _CreateNewArticleState extends State<CreateNewArticle> {
  YourArticle yourArticle = YourArticle(
    publishedAt: DateTime.now().toString(),
    author: FirebaseHelper.shared.auth.currentUser?.email,
    urlToImage: FirebaseHelper.shared.auth.currentUser?.email,
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.createNewArticle,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.size20,
              vertical: Constants.size25,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    title: AppStrings.titleArticle,
                    hintText: AppStrings.titleArticleInput,
                    maxLine: 3,
                    onChanged: (String title) {
                      yourArticle.title = title;
                    },
                  ),
                  SizedBox(
                    height: Constants.size25,
                  ),
                  CustomTextField(
                    title: AppStrings.descArticle,
                    hintText: AppStrings.descArticleInput,
                    maxLine: 5,
                    onChanged: (String describe) {
                      yourArticle.describe = describe;
                    },
                  ),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: Constants.size150,
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.size20,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.darkSilver,
                      ),
                      borderRadius: BorderRadius.circular(Constants.size10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppResource.camera,
                          width: Constants.size40,
                          color: AppColor.darkSilver,
                        ),
                        SizedBox(
                          height: Constants.size5,
                        ),
                        const TextView(
                          text: AppStrings.uploadImage,
                          textColor: AppColor.darkSilver,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  Button(
                    bgColor: AppColor.black,
                    text: AppStrings.postArticle,
                    textColor: AppColor.white,
                    onTap: () {
                      tryCreateNewYourArticle();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void tryCreateNewYourArticle() {
    if (_formKey.currentState!.validate()) {
      getIt
          .get<YourArticleBloc>()
          .add(CreateNewYourArticleEvent(yourArticle: yourArticle));
    } else {
      Loading.showError(AppStrings.failed);
    }
  }
}
