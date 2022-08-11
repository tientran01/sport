import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

import '../../application/application.dart';

class TeslaArticleScreen extends StatefulWidget {
  const TeslaArticleScreen({Key? key}) : super(key: key);

  @override
  State<TeslaArticleScreen> createState() => _TeslaArticleScreenState();
}

class _TeslaArticleScreenState extends State<TeslaArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<ArticleBloc>().add(
              const GetEverythingEvent(
                nameCategory: Application.teslaParamValue,
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: getIt.get<ArticleBloc>(),
      builder: (context, state) {
        List<Article>? articles = state.articles;
        return ListView.builder(
          itemCount: articles?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Constants.size15,
              ),
              child: ArticleItem(
                article: articles?[index],
                onTap: () {
                  NavigationService.navigatorKey.currentState?.pushNamed(
                    AppRouteName.detailArticle,
                    arguments: articles?[index],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
