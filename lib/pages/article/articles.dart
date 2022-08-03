import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class Articles extends StatelessWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
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
      },
    );
  }
}
