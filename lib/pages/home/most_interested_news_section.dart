import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_event.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class MostInterestedNewsSection extends StatefulWidget {
  const MostInterestedNewsSection({Key? key}) : super(key: key);

  @override
  State<MostInterestedNewsSection> createState() =>
      _MostInterestedNewsSectionState();
}

class _MostInterestedNewsSectionState extends State<MostInterestedNewsSection> {
  @override
  void initState() {
    super.initState();
    getIt.get<MostInterestedNewsBloc>().add(const MostInterestedNewsApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.size470,
      child: BlocBuilder<MostInterestedNewsBloc, MostInterestedNewsState>(
        bloc: getIt.get<MostInterestedNewsBloc>(),
        builder: (context, homeState) {
          if (homeState is MostInterestedNewsLoading) {
            return const CircularLoading();
          }
          if (homeState is MostInterestedNewsLoader) {
            if (homeState.articles == null) {
              return Center(
                child: Image.asset(AppResource.empty),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index >= 3) {
                          return Container();
                        }
                        return ArticleItem(
                          article: homeState.articles?.elementAt(index),
                          onTap: () {
                            NavigationService.navigatorKey.currentState
                                ?.pushNamed(
                              AppRouteName.detailArticle,
                              arguments: homeState.articles?.elementAt(index),
                            );
                          },
                        );
                      },
                      itemCount: 3,
                    ),
                  ),
                  SizedBox(
                    height: Constants.size10,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigatorKey.currentState?.pushNamed(
                        AppRouteName.articleSortByName,
                        arguments: AppStrings.mostInterested,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.zero,
                      height: Constants.size60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppColor.gainsboro,
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: AppColor.gainsboro,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: TextView(
                          text: AppStrings.seeMore,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }
          return Center(
            child: TextView(
              text: AppStrings.error,
              fontSize: Constants.size15,
            ),
          );
        },
      ),
    );
  }
}
