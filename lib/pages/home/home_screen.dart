import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/name_section.dart';
import 'package:sport_app/component/shimmer.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/article/components/article_item_section.dart';
import 'package:sport_app/pages/home/component/custom_slider.dart';
import 'package:sport_app/pages/home/component/header_home.dart';
import 'package:sport_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/pages/video_player/component/video_thumbnai_item.dart';
import 'package:sport_app/resource/resource.dart';
import '../../component/text_view.dart';
import '../../router/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  List<Video> videos = AppStrings.videos;
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
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: HeaderHome(
                notificationCount: state.badge,
                onTap: () {
                  NavigationService.navigatorKey.currentState
                      ?.pushNamed(AppRouteName.notification);
                }),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.size15,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: Constants.size20,
                    ),
                    const CustomSlider(),
                    SizedBox(
                      height: Constants.size25,
                    ),
                    NameSection(
                      titleSection: AppStrings.hotNews,
                      text: AppStrings.seeMore,
                      onTap: () {
                        NavigationService.navigatorKey.currentState?.pushNamed(
                          AppRouteName.articleSortByName,
                          arguments: AppStrings.hotNews,
                        );
                      },
                    ),
                    SizedBox(
                      height: Constants.size10,
                    ),
                    SizedBox(
                      height: Constants.size250,
                      child: BlocBuilder<ArticleBloc, ArticleState>(
                        bloc: ArticleBloc.of(context)
                          ..add(const GetTopHeadlinesWithSourceEvent()),
                        builder: (context, articleHomeState) {
                          if (articleHomeState is ArticleLoading) {
                            return const ShimmerArticleCustomWidth();
                          }
                          if (articleHomeState is ArticleLoader) {
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  ArticleCustomWidthItem(
                                article:
                                    articleHomeState.articles?.elementAt(index),
                                onTap: () {
                                  NavigationService.navigatorKey.currentState
                                      ?.pushNamed(
                                    AppRouteName.detailArticle,
                                    arguments: articleHomeState.articles
                                        ?.elementAt(index),
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
                          }
                          return const Center(
                            child: Text(AppStrings.error),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: Constants.size20,
                    ),
                    const NameSection(
                      titleSection: AppStrings.mostInterested,
                    ),
                    SizedBox(
                      height: Constants.size470,
                      child: BlocBuilder<ArticleBloc, ArticleState>(
                        bloc: ArticleBloc.of(context)
                          ..add(const GetTopHeadlinesEvent()),
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
                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        if (index >= 3) {
                                          return Container();
                                        }
                                        return ArticleItem(
                                          article: articleHomeState.articles
                                              ?.elementAt(index),
                                          onTap: () {
                                            NavigationService
                                                .navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRouteName.detailArticle,
                                              arguments: articleHomeState
                                                  .articles
                                                  ?.elementAt(index),
                                            );
                                          },
                                        );
                                      },
                                      itemCount: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Constants.size10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      NavigationService
                                          .navigatorKey.currentState
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
                                    ?.pushNamed(
                                  AppRouteName.videoPlayer,
                                  arguments: videos.elementAt(index),
                                );
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
          ),
        );
      },
    );
  }
}
