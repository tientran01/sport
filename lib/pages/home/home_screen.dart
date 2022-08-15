import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_state.dart';
import 'package:sport_app/component/name_section.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/home/component/custom_slider.dart';
import 'package:sport_app/pages/home/component/header_home.dart';
import 'package:sport_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/pages/home/most_interested_news_section.dart';
import 'package:sport_app/pages/home/hot_news_section.dart';
import 'package:sport_app/pages/video_player/component/video_thumbnai_item.dart';
import 'package:sport_app/resource/resource.dart';
import '../../router/navigation_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Video> videos = AppStrings.videos;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: getIt<HomeBloc>(),
      builder: (_, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: const HeaderHome(),
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
                  const HotNewsSection(),
                  SizedBox(
                    height: Constants.size20,
                  ),
                  const NameSection(
                    titleSection: AppStrings.mostInterested,
                  ),
                  const MostInterestedNewsSection(),
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
        );
      },
    );
  }
}
