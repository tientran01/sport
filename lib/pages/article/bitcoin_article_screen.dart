import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_bloc.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_event.dart';
import 'package:sport_app/bloc/article/hot_news_bloc/hot_news_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class BitcoinArticleScreen extends StatefulWidget {
  const BitcoinArticleScreen({Key? key}) : super(key: key);

  @override
  State<BitcoinArticleScreen> createState() => _BitcoinArticleScreenState();
}

class _BitcoinArticleScreenState extends State<BitcoinArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<HotNewsBloc>().add(const HotNewsLoadApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotNewsBloc, HotNewsState>(
      bloc: getIt.get<HotNewsBloc>(),
      builder: (context, state) {
        if (state is HotNewsLoading) {
          return const CircularLoading();
        }
        if (state is HotNewsLoader) {
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
        return Center(
          child: Image.asset(AppResource.empty),
        );
      },
    );
  }
}
