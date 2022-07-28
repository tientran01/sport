import 'package:sport_app/bloc/home/bloc/home_bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_event.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/component/name_section.dart';
import 'package:sport_app/pages/home/component/custom_slider.dart';
import 'package:sport_app/pages/home/component/header_home.dart';
import 'package:sport_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/pages/home/component/article_item_section.dart';
import 'package:sport_app/pages/home/drawer_home.dart';
import 'package:sport_app/pages/home/home_category_bar.dart';
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
          drawer: const DrawerHome(),
          body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraint.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.size15,
                    ),
                    child: Column(
                      children: [
                        const HomeCategoryBar(),
                        SizedBox(
                          height: Constants.size25,
                        ),
                        const CustomSlider(),
                        SizedBox(
                          height: Constants.size25,
                        ),
                        NameSection(
                          titleSection: AppStrings.justForYou,
                          onTap: () {},
                          text: AppStrings.seeMore,
                        ),
                        SizedBox(
                          height: Constants.size10,
                        ),
                        Column(
                          children: [
                            ArticleItemSection(
                              category: "general",
                              title: AppStrings.newsTitleDemo,
                              author: "Monica-Saia",
                              onTap: () {
                                NavigationService.navigatorKey.currentState
                                    ?.pushNamed(AppRouteName.detailArticle);
                              },
                            ),
                            ArticleItemSection(
                              category: "general",
                              title: AppStrings.newsTitleDemo,
                              author: "Monica-Saia",
                              onTap: () {
                                NavigationService.navigatorKey.currentState
                                    ?.pushNamed(AppRouteName.detailArticle);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
