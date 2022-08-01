import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/main.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
        bloc: getIt.get<ArticleBloc>(),
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
                        getIt.get<ArticleBloc>().add(
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
                        getIt.get<ArticleBloc>().add(
                              GetArticleFromTextFieldEvent(
                                description: description,
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: Constants.size20,
                    ),
                    SizedBox(
                      height: Constants.size20,
                    ),
                    Button(
                      bgColor: AppColor.black,
                      text: AppStrings.postArticle,
                      textColor: AppColor.white,
                      onTap: () {
                        getIt.get<ArticleBloc>().add(CreateNewArticleEvent());
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
