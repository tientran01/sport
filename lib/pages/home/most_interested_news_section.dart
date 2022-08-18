import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/most_interested_news/cubit/most_interested_news_cubit.dart';
import 'package:sport_app/cubit/news/most_interested_news/cubit/most_interested_news_state.dart';
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
    getIt.get<MostInterestedNewsCubit>().getMostInterestedNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.size470,
      child: BlocBuilder<MostInterestedNewsCubit, MostInterestedNewsState>(
        bloc: getIt.get<MostInterestedNewsCubit>(),
        builder: (context, state) {
          switch (state.status) {
            case NewsStatus.error:
              TextView(
                text: AppStrings.error,
                fontSize: Constants.size20,
                fontWeight: FontWeight.w700,
              );
              break;
            case NewsStatus.success:
              if (state.articles?.isEmpty == true) {
                return Center(
                  child: Image.asset(AppResource.empty),
                );
              }
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
                          article: state.articles?.elementAt(index),
                          onTap: () {
                            NavigationService.navigatorKey.currentState
                                ?.pushNamed(
                              AppRouteName.detailArticle,
                              arguments: state.articles?.elementAt(index),
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
                      decoration: BoxDecoration(
                        color: AppColor.gainsboro.withOpacity(0.8),
                        border: Border.all(
                          color: AppColor.gainsboro,
                        ),
                      ),
                      child: const Center(
                        child: TextView(
                          text: AppStrings.seeMore,
                          fontWeight: FontWeight.w700,
                          textColor: AppColor.arsenic,
                        ),
                      ),
                    ),
                  )
                ],
              );

            default:
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
