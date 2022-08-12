import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/tesla_news_bloc/tesla_news_bloc.dart';
import 'package:sport_app/bloc/article/tesla_news_bloc/tesla_news_event.dart';
import 'package:sport_app/bloc/article/tesla_news_bloc/tesla_news_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class TeslaArticleScreen extends StatefulWidget {
  const TeslaArticleScreen({Key? key}) : super(key: key);

  @override
  State<TeslaArticleScreen> createState() => _TeslaArticleScreenState();
}

class _TeslaArticleScreenState extends State<TeslaArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<TeslaNewsBloc>().add(const TeslaNewsApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeslaNewsBloc, TeslaNewsState>(
      bloc: getIt.get<TeslaNewsBloc>(),
      builder: (context, state) {
        if (state is TeslaNewsLoading) {
          return const CircularLoading();
        }
        if (state is TeslaNewsLoader) {
          if (state.articles == null) {
            return Center(
              child: Image.asset(AppResource.empty),
            );
          } else {
            return ListView.builder(
              itemCount: state.articles?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.size15,
                  ),
                  child: ArticleItem(
                    article: state.articles?[index],
                    onTap: () {
                      NavigationService.navigatorKey.currentState?.pushNamed(
                        AppRouteName.detailArticle,
                        arguments: state.articles?[index],
                      );
                    },
                  ),
                );
              },
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
    );
  }
}
