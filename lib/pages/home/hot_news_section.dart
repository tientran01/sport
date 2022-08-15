import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_bloc.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_event.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_state.dart';
import 'package:sport_app/component/shimmer.dart';
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
    getIt.get<HotNewsBloc>().add(const HotNewsLoadApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.size250,
      child: BlocBuilder<HotNewsBloc, HotNewsState>(
        bloc: getIt.get<HotNewsBloc>(),
        builder: (context, state) {
          if (state is HotNewsLoading) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ShimmerArticleCustomWidth();
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: Constants.size10,
                );
              },
            );
          }
          if (state is HotNewsLoader) {
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
          }
          return const Center(
            child: Text(AppStrings.error),
          );
        },
      ),
    );
  }
}
