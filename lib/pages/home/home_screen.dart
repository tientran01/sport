import 'package:shimmer/shimmer.dart';
import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/name_section.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/pages/home/component/article_item.dart';
import 'package:sport_app/pages/home/component/custom_slider.dart';
import 'package:sport_app/pages/home/component/header_home.dart';
import 'package:sport_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/pages/home/component/search.dart';
import 'package:sport_app/resource/resource.dart';
import '../../router/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    getIt.get<HomeBloc>().add(const UpdateBadgeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: getIt<HomeBloc>(),
      builder: (_, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: HeaderHome(
            notificationCount: state.badge,
            onTap: () => NavigationService.navigatorKey.currentState
                ?.pushNamed(AppRouteName.notification),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Constants.size15,
              ),
              child: Column(
                children: [
                  const Search(),
                  SizedBox(
                    height: Constants.size15,
                  ),
                  BlocProvider<ArticleBloc>(
                    create: (context) =>
                        ArticleBloc()..add(const GetTopHeadlinesEvent()),
                    child: const CustomSlider(),
                  ),
                  SizedBox(
                    height: Constants.size25,
                  ),
                  NameSection(
                    titleSection: AppStrings.hotNews,
                    text: AppStrings.seeMore,
                    onTap: () {
                      NavigationService.navigatorKey.currentState
                          ?.pushNamed(AppRouteName.article);
                    },
                  ),
                  SizedBox(
                    height: Constants.size10,
                  ),
                  BlocProvider<ArticleBloc>(
                    create: (context) => ArticleBloc()
                      ..add(const GetTopHeadlinesWithSourceEvent()),
                    child: SizedBox(
                      height: Constants.size250,
                      child: BlocConsumer<ArticleBloc, ArticleState>(
                        listener: (BuildContext context, ArticleState state) {},
                        builder: (context, articleHomeState) {
                          if (articleHomeState is LoadingArticle) {
                            return const CircularLoading();
                          } else if (articleHomeState is FailureArticle) {
                            return Text("${articleHomeState.error}");
                          }
                          // ignore: unnecessary_type_check
                          if (articleHomeState is ArticleState) {
                            if (articleHomeState.articles == null) {
                              return Shimmer.fromColors(
                                  baseColor: AppColor.black,
                                  highlightColor: AppColor.jetStream,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return const ArticleItemShimmer();
                                    },
                                    itemCount:
                                        articleHomeState.articles?.length ?? 0,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        width: Constants.size10,
                                      );
                                    },
                                  ));
                            } else {
                              List<Article>? articles =
                                  articleHomeState.articles;
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => ArticleItem(
                                  article: articles?.elementAt(index),
                                  onTap: () {
                                    NavigationService.navigatorKey.currentState
                                        ?.pushNamed(
                                      AppRouteName.detailArticle,
                                      arguments: articles?.elementAt(index),
                                    );
                                  },
                                ),
                                itemCount:
                                    articleHomeState.articles?.length ?? 0,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: Constants.size10,
                                  );
                                },
                              );
                            }
                          } else {
                            return const CircularLoading();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
