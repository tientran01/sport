import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_event.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_state.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/video_player/component/video_button.dart';
import 'package:sport_app/pages/video_player/component/video_detail.dart';
import 'package:sport_app/pages/video_player/component/video_tile.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool isFavorite = true;
  @override
  Widget build(BuildContext context) {
    Video video = ModalRoute.of(context)?.settings.arguments as Video;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
        leftIconColor: AppColor.white,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoTile(
            video: video,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: Constants.size100,
                  child: VideoDetail(
                    video: video,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: Constants.size45),
                  height: Constants.size350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<FavoriteBloc, FavoriteState>(
                        bloc: getIt.get<FavoriteBloc>(),
                        builder: (context, state) {
                          return VideoButton(
                            iconPath: AppResource.heart,
                            onTap: () {
                              getIt.get<FavoriteBloc>().add(
                                    AddVideoToFavoriteEvent(video: video),
                                  );
                            },
                            iconColor: isFavorite
                                ? AppColor.white
                                : AppColor.carminePink,
                          );
                        },
                      ),
                      SizedBox(
                        height: Constants.size25,
                      ),
                      ImageCircle(
                        imageUrl: video.thumbnailUrl,
                        width: Constants.size45,
                        height: Constants.size45,
                        isEdit: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
