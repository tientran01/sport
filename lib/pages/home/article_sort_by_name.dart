import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

// ignore: must_be_immutable
class ArticleSortByName extends StatelessWidget {
  late String? nameArticle;
  ArticleSortByName({Key? key, this.nameArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    nameArticle = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: CustomAppBar(
        title: nameArticle,
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
      body: BlocProvider<ArticleBloc>(
        create: (context) =>
            ArticleBloc()..add(const GetTopHeadlinesWithSourceEvent()),
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, articleHomeState) {
            List<Article>? articles = articleHomeState.articles;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.size15),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => ArticleItemOfRow(
                  article: articles?.elementAt(index),
                  onTap: () {
                    NavigationService.navigatorKey.currentState?.pushNamed(
                      AppRouteName.detailArticle,
                      arguments: articles?.elementAt(index),
                    );
                  },
                ),
                itemCount: articleHomeState.articles?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: Constants.size10,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
