import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/pages/home/component/article_item_section.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    super.initState();
    getIt.get<ArticleBloc>().add(const GetAllArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState
              ?.pushNamed(AppRouteName.main);
        },
        title: AppStrings.news,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Constants.size20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ArticleBloc, ArticleState>(
                    bloc: getIt.get<ArticleBloc>(),
                    builder: (context, state) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ArticleItemSection(
                            article: state.articles?.elementAt(index),
                            onTap: () {
                              NavigationService.navigatorKey.currentState
                                  ?.pushNamed(
                                AppRouteName.detailArticle,
                                arguments: state.articles?.elementAt(index),
                              );
                            },
                          );
                        },
                        itemCount: state.articles?.length,
                        physics: const BouncingScrollPhysics(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
