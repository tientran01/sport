import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/slide_route/slide_bottom_route.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/helper/timeago_helper.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/create_new_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class YourArticleScreen extends StatefulWidget {
  const YourArticleScreen({Key? key}) : super(key: key);

  @override
  State<YourArticleScreen> createState() => _YourArticleScreenState();
}

class _YourArticleScreenState extends State<YourArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<YourArticleBloc>().add(GetAllYourArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.yourArticle,
        isPop: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.black,
        onPressed: () {
          NavigationService.navigatorKey.currentState?.push(
            SlideBottomRoute(
              page: const CreateNewArticle(),
            ),
          );
        },
        child: Image.asset(
          AppResource.create,
          width: Constants.size27,
          color: AppColor.white,
        ),
      ),
      body: BlocBuilder<YourArticleBloc, YourArticleState>(
        bloc: getIt.get<YourArticleBloc>(),
        builder: (context, state) {
          if (state is YourArticleLoading) {
            return const CircularLoading();
          }
          if (state is YourArticleLoader) {
            if (state.yourArticles == null) {
              return Center(
                child: Image.asset(AppResource.empty),
              );
            } else {
              return ListView.builder(
                itemCount: state.yourArticles?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: Constants.size10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(Constants.size10),
                      margin: EdgeInsets.symmetric(vertical: Constants.size10),
                      decoration: BoxDecoration(
                        color: AppColor.gainsboro.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(Constants.size10),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              CustomImage(
                                imageUrl: AppNetwork.imageAvatar,
                                width: Constants.size100,
                                height: Constants.size100,
                              ),
                              SizedBox(
                                height: Constants.size10,
                              ),
                              Container(
                                padding: EdgeInsets.all(Constants.size5),
                                decoration: BoxDecoration(
                                  color: AppColor.gainsboro.withOpacity(0.6),
                                  borderRadius:
                                      BorderRadius.circular(Constants.size10),
                                ),
                                child: TextView(
                                  text: TimeagoHelper.parseDatetime(
                                    state.yourArticles
                                        ?.elementAt(index)
                                        .publishedAt
                                        .toString(),
                                  ),
                                  fontSize: Constants.size10,
                                  textColor: AppColor.arsenic,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: Constants.size10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextView(
                                  text: state.yourArticles
                                      ?.elementAt(index)
                                      .title,
                                  fontSize: Constants.size17,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height: Constants.size5,
                                ),
                                TextView(
                                  text: state.yourArticles
                                      ?.elementAt(index)
                                      .describe,
                                  fontSize: Constants.size15,
                                  textColor: AppColor.darkSilver,
                                  lineNumber: 3,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(
                                  height: Constants.size20,
                                ),
                                Row(
                                  children: [
                                    TextView(
                                      text: AppStrings.author,
                                      textColor: AppColor.darkSilver,
                                      fontSize: Constants.size12,
                                    ),
                                    SizedBox(
                                      width: Constants.size5,
                                    ),
                                    SizedBox(
                                      width: Constants.size150,
                                      child: TextView(
                                        text: state.yourArticles
                                            ?.elementAt(index)
                                            .author,
                                        textColor: AppColor.arsenic,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Constants.size10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.carminePink
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(
                                            Constants.size5,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(
                                          Constants.size5,
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppResource.delete,
                                              width: Constants.size25,
                                            ),
                                            TextView(
                                              text:
                                                  AppStrings.deleteYourArticle,
                                              fontSize: Constants.size12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Constants.size15,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.jetStream
                                              .withOpacity(0.7),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(
                                          Constants.size5,
                                        ),
                                        child: Image.asset(
                                          AppResource.edit,
                                          width: Constants.size20,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: TextView(
              text: AppStrings.error,
              fontSize: Constants.size15,
              fontWeight: FontWeight.w700,
            ),
          );
        },
      ),
    );
  }
}
