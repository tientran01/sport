import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
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
    getIt.get<ArticleBloc>().add(
          const GetEverythingEvent(
            nameCategory: Application.appleParamValue,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: getIt.get<ArticleBloc>(),
      builder: (context, state) {
        if (state is ArticleLoading) {
          return const CircularLoading();
        }
        if (state is ArticleLoader) {
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
        return const Center(
          child: Text("No data"),
        );
      },
    );
  }
}
