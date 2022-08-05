import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

// ignore: must_be_immutable
class ArticleSortByName extends StatefulWidget {
  const ArticleSortByName({Key? key}) : super(key: key);

  @override
  State<ArticleSortByName> createState() => _ArticleSortByNameState();
}

class _ArticleSortByNameState extends State<ArticleSortByName> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? nameArticle = ModalRoute.of(context)?.settings.arguments as String;
    switch (nameArticle) {
      case AppStrings.hotNews:
        setState(() {
          getIt.get<ArticleBloc>().add(const GetTopHeadlinesWithSourceEvent());
        });
        break;
      case AppStrings.mostInterested:
        setState(() {
          getIt.get<ArticleBloc>().add(const GetTopHeadlinesEvent());
        });
        break;
      default:
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: nameArticle,
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        bloc: getIt.get<ArticleBloc>(),
        builder: (context, articleHomeState) {
          List<Article>? articles = articleHomeState.articles;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.size15,
            ),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => ArticleItem(
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
    );
  }
}
