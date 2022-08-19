import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_bloc.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_event.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_state.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_bloc.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_event.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/lang.dart';
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
    AppLocalizations local = AppLocalizations.of(context);
    String? nameArticle = ModalRoute.of(context)?.settings.arguments as String;
    switch (nameArticle) {
      case AppStrings.hotNews:
        nameArticle = local.hotNews;
        setState(() {
          getIt.get<HotNewsBloc>().add(const HotNewsLoadApiEvent());
        });
        break;
      case AppStrings.mostInterested:
        nameArticle = local.mostInterested;
        setState(() {
          getIt.get<MostInterestedNewsBloc>().add(
                const MostInterestedNewsApiEvent(),
              );
        });
        break;

      default:
        break;
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: nameArticle,
      ),
      body: BlocBuilder<HotNewsBloc, HotNewsState>(
        bloc: getIt.get<HotNewsBloc>(),
        builder: (context, state) {
          if (state is HotNewsLoading) {
            return const CircularLoading();
          }
          if (state is HotNewsLoader) {
            if (state.articles == null) {
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
                ),
              );
            }
          }
          return Center(
            child: TextView(
              text: local.error,
              fontSize: Constants.size15,
            ),
          );
        },
      ),
    );
  }
}
