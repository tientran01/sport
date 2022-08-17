import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/cubit/enum_status/status.dart';
import 'package:sport_app/cubit/news/hot_news/cubit/hot_news_state.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class HotNewsSection extends StatefulWidget {
  const HotNewsSection({Key? key}) : super(key: key);

  @override
  State<HotNewsSection> createState() => _HotNewsSectionState();
}

class _HotNewsSectionState extends State<HotNewsSection> {
  @override
  void initState() {
    super.initState();
    getIt.get<HotNewsCubit>().getHotNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.size250,
      child: BlocBuilder<HotNewsCubit, HotNewsState>(
        bloc: getIt.get<HotNewsCubit>(),
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
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ArticleCustomWidthItem(
                  article: state.articles?.elementAt(index),
                  onTap: () {
                    NavigationService.navigatorKey.currentState?.pushNamed(
                      AppRouteName.detailArticle,
                      arguments: state.articles?.elementAt(index),
                    );
                  },
                ),
                itemCount: state.articles?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: Constants.size10,
                  );
                },
              );
            default:
          }
          return const CircularLoading();
        },
      ),
    );
  }
}
