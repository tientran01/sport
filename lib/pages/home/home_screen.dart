import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/component/name_section.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/pages/home/component/custom_slider.dart';
import 'package:sport_app/pages/home/component/header_home.dart';
import 'package:sport_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/pages/home/component/search.dart';
import 'package:sport_app/pages/video_player/component/video_thumbnai_item.dart';
import 'package:sport_app/resource/resource.dart';
import '../../router/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  List<Video> videos = Video.videos;
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
                      child: BlocBuilder<ArticleBloc, ArticleState>(
                        builder: (context, articleHomeState) {
                          List<Article>? articles = articleHomeState.articles;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                ArticleItemOfColumn(
                              article: articles?.elementAt(index),
                              onTap: () {
                                NavigationService.navigatorKey.currentState
                                    ?.pushNamed(
                                  AppRouteName.detailArticle,
                                  arguments: articles?.elementAt(index),
                                );
                              },
                            ),
                            itemCount: articleHomeState.articles?.length ?? 0,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: Constants.size10,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  const NameSection(
                    titleSection: AppStrings.mostInterested,
                  ),
                  BlocProvider<ArticleBloc>(
                    create: (context) =>
                        ArticleBloc()..add(const GetTopHeadlinesEvent()),
                    child: SizedBox(
                      height: Constants.size470,
                      child: BlocBuilder<ArticleBloc, ArticleState>(
                        builder: (context, articleHomeState) {
                          List<Article>? articles = articleHomeState.articles;
                          return Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children:
                                      List<int>.generate(3, (index) => index)
                                          .map(
                                            (e) => ArticleItemOfRow(
                                              article: articles?.elementAt(e),
                                              onTap: () {
                                                NavigationService
                                                    .navigatorKey.currentState
                                                    ?.pushNamed(
                                                  AppRouteName.detailArticle,
                                                  arguments:
                                                      articles?.elementAt(e),
                                                );
                                              },
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                              SizedBox(
                                height: Constants.size10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  NavigationService.navigatorKey.currentState
                                      ?.pushNamed(
                                    AppRouteName.articleSortByName,
                                    arguments: AppStrings.mostInterested,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  height: Constants.size60,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: AppColor.gainsboro,
                                    border: Border.symmetric(
                                      horizontal: BorderSide(
                                        color: AppColor.gainsboro,
                                      ),
                                    ),
                                  ),
                                  child: const Center(
                                    child: TextView(
                                      text: AppStrings.seeMore,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  const NameSection(
                    titleSection: AppStrings.hotVideos,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Constants.size5),
                    height: Constants.size300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(Constants.size5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Constants.size15,
                            ),
                            color: AppColor.gainsboro.withOpacity(0.3),
                          ),
                          height: Constants.size270,
                          width: Constants.size250,
                          child: VideoThumbnaiLargeItem(
                            video: videos.elementAt(index),
                            onTap: () {
                              NavigationService.navigatorKey.currentState
                                  ?.pushNamed(AppRouteName.videoPlayer);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: Constants.size10,
                        );
                      },
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
