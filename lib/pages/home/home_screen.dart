import 'package:sport_app/bloc/article/bloc/article_event.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/component/name_section.dart';
import 'package:sport_app/pages/home/component/article_item.dart';
import 'package:sport_app/pages/home/component/custom_slider.dart';
import 'package:sport_app/pages/home/component/header_home.dart';
import 'package:sport_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/pages/home/component/search.dart';
import 'package:sport_app/pages/home/drawer_home.dart';
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
    getIt.get<ArticleBloc>().add(const GetTopArticleEvent());
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
          drawer: const DrawerHome(),
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
                  const CustomSlider(),
                  SizedBox(
                    height: Constants.size25,
                  ),
                  NameSection(
                    titleSection: AppStrings.justForYou,
                    text: AppStrings.seeMore,
                    onTap: () {
                      NavigationService.navigatorKey.currentState
                          ?.pushNamed(AppRouteName.article);
                    },
                  ),
                  SizedBox(
                    height: Constants.size10,
                  ),
                  SizedBox(
                    height: Constants.size250,
                    child: BlocBuilder<ArticleBloc, ArticleState>(
                        bloc: getIt.get<ArticleBloc>(),
                        builder: (context, state) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => ArticleItem(
                              article: state.articles?.elementAt(index),
                              onTap: () {
                                NavigationService.navigatorKey.currentState
                                    ?.pushNamed(
                                  AppRouteName.detailArticle,
                                  arguments: state.articles?.elementAt(index),
                                );
                              },
                            ),
                            itemCount: state.articles?.length ?? 0,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: Constants.size10,
                              );
                            },
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
