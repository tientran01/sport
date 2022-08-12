import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

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
        {
          setState(
            () {
              getIt
                  .get<ArticleBloc>()
                  .add(const GetTopHeadlinesWithSourceEvent());
            },
          );
        }
        break;
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: nameArticle,
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        bloc: getIt.get<ArticleBloc>(),
        builder: (context, articleHomeState) {
          if (articleHomeState is ArticleLoading) {
            return const CircularLoading();
          }
          if (articleHomeState is ArticleLoader) {
            if (articleHomeState.articles == null) {
              return Center(
                child: Image.asset(AppResource.empty),
              );
            } else {
              return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.size15,
            ),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => ArticleItem(
                article: articleHomeState.articles?.elementAt(index),
                onTap: () {
                  NavigationService.navigatorKey.currentState?.pushNamed(
                    AppRouteName.detailArticle,
                    arguments: articleHomeState.articles?.elementAt(index),
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
