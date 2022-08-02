import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class Articles extends StatelessWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is LoadingArticle) {
          return ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              return const ArticleItemShimmer();
            },
          );
        } else if (state is FailureArticle) {
          return Text("${state.error}");
        }
        // ignore: unnecessary_type_check
        if (state is ArticleState) {
          if (state.articles == null) {
            return Shimmer.fromColors(
              baseColor: AppColor.black,
              highlightColor: AppColor.jetStream,
              child: ListView.builder(
                itemCount: state.articles?.length,
                itemBuilder: (context, index) {
                  return const ArticleItemShimmer();
                },
              ),
            );
          } else {
            List<Article>? articles = state.articles;
            return ListView.builder(
              itemCount: articles?.length,
              itemBuilder: (context, index) {
                return ArticleItemSection(
                  article: articles?.elementAt(index),
                  onTap: () {
                    NavigationService.navigatorKey.currentState?.pushNamed(
                      AppRouteName.detailArticle,
                      arguments: articles?.elementAt(index),
                    );
                  },
                );
              },
            );
          }
        }
        return const CircularLoading();
      },
      listener: (BuildContext context, ArticleState state) {},
    );
  }
}
