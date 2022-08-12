import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/apple_news_bloc/apple_news_bloc.dart';
import 'package:sport_app/bloc/article/apple_news_bloc/apple_news_event.dart';
import 'package:sport_app/bloc/article/apple_news_bloc/apple_news_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class AppleArticleScreen extends StatefulWidget {
  const AppleArticleScreen({Key? key}) : super(key: key);

  @override
  State<AppleArticleScreen> createState() => _AppleArticleScreenState();
}

class _AppleArticleScreenState extends State<AppleArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<AppleNewsBloc>().add(const AppleNewsApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppleNewsBloc, AppleNewsState>(
      bloc: getIt.get<AppleNewsBloc>(),
      builder: (context, state) {
        if (state is AppleNewsLoading) {
          return const CircularLoading();
        }
        if (state is AppleNewsLoader) {
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
