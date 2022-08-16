import 'package:flutter/material.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/resource/resource.dart';

import '../../component/custom_text_field.dart';

class EditYourArticleScreen extends StatelessWidget {
  const EditYourArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YourArticle yourArticle =
        ModalRoute.of(context)?.settings.arguments as YourArticle;
    YourArticle newYourArticle = YourArticle(
      publishedAt: DateTime.now().toString(),
      id: yourArticle.id,
    );
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editYourArticle,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.size20,
            vertical: Constants.size25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                title: AppStrings.titleArticle,
                hintText: yourArticle.title ?? AppStrings.titleArticleInput,
                maxLine: 3,
                onChanged: (String title) {
                  newYourArticle.title = title;
                },
              ),
              SizedBox(
                height: Constants.size25,
              ),
              CustomTextField(
                title: AppStrings.descArticle,
                hintText: yourArticle.describe ?? AppStrings.descArticleInput,
                maxLine: 5,
                onChanged: (String describe) {
                  newYourArticle.describe = describe;
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
                text: AppStrings.editYourArticle,
                textColor: AppColor.white,
                onTap: () {
                  getIt.get<YourArticleBloc>().add(
                        UpdateYourArticleEvent(
                          id: yourArticle.id ?? 0,
                          yourArticle: newYourArticle,
                        ),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
