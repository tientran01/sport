import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_bloc.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_event.dart';
import 'package:sport_app/bloc/your_article/bloc/your_article_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/slide_route/slide_bottom_route.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/create_new_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class YourArticleScreen extends StatefulWidget {
  const YourArticleScreen({Key? key}) : super(key: key);

  @override
  State<YourArticleScreen> createState() => _YourArticleScreenState();
}

class _YourArticleScreenState extends State<YourArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<YourArticleBloc>().add(GetYourArticlesEvent());
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
          if (state.yourArticles == null) {
            return Center(child: Image.asset(AppResource.empty));
          }
          return ListView.builder(
            itemCount: state.yourArticles?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.size10),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: Constants.size120,
                      padding: EdgeInsets.all(Constants.size10),
                      margin: EdgeInsets.symmetric(vertical: Constants.size10),
                      decoration: BoxDecoration(
                        color: AppColor.gainsboro.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(Constants.size10),
                      ),
                      child: Row(
                        children: [
                          CustomImage(
                            imageUrl: AppNetwork.imageAvatar,
                            width: Constants.size100,
                            height: Constants.size100,
                          ),
                          SizedBox(
                            width: Constants.size20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextView(
                                text:
                                    state.yourArticles?.elementAt(index).title,
                                fontSize: Constants.size15,
                                fontWeight: FontWeight.w700,
                              ),
                              TextView(
                                text: state.yourArticles
                                    ?.elementAt(index)
                                    .description,
                                fontSize: Constants.size15,
                                textColor: AppColor.darkSilver,
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
                                  text: timeago.format(
                                    DateTime.parse(
                                      state.yourArticles
                                              ?.elementAt(index)
                                              .publishedAt ??
                                          DateTime.now().toString(),
                                    ),
                                  ),
                                  fontSize: Constants.size10,
                                  textColor: AppColor.arsenic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          getIt.get<YourArticleBloc>().add(
                                DeleteYourArticleEvent(
                                    id: state.yourArticles
                                        ?.elementAt(index)
                                        .id),
                              );
                        },
                        child: Container(
                          padding: EdgeInsets.all(Constants.size5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                          ),
                          child: Image.asset(
                            AppResource.delete,
                            width: Constants.size30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
