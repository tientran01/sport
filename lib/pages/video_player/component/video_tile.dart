import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_bloc.dart';
import 'package:sport_app/bloc/favorite/bloc/favorite_state.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/main.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/video_player/component/video_button.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:video_player/video_player.dart';
import '../../../bloc/favorite/bloc/favorite_event.dart';

class VideoTile extends StatefulWidget {
  final Video? video;
  const VideoTile({
    Key? key,
    this.video,
  }) : super(key: key);

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController videoPlayerController;
  Future<void>? initializeVideoPlayerFuture;
  bool isVideoPlaying = true;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
      "${widget.video?.videoUrl}",
      videoPlayerOptions: VideoPlayerOptions(),
    );
    initializeVideoPlayerFuture = videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
    videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  void pauseVideo() {
    isVideoPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();
    setState(() {
      isVideoPlaying = !isVideoPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    (isVideoPlaying)
        ? videoPlayerController.play
        : videoPlayerController.pause();
    return Container(
      height: Constants.size200,
      width: MediaQuery.of(context).size.width,
      color: AppColor.gainsboro.withOpacity(0.1),
      child: FutureBuilder(
        future: initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                pauseVideo();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 2 / 1,
                    child: VideoPlayer(videoPlayerController),
                  ),
                  IconButton(
                    onPressed: () {
                      pauseVideo();
                    },
                    icon: Image.asset(
                      AppResource.play,
                      color:
                          AppColor.white.withOpacity(isVideoPlaying ? 0 : 0.9),
                      width: Constants.size60,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<FavoriteBloc, FavoriteState>(
                            bloc: getIt.get<FavoriteBloc>(),
                            builder: (context, state) {
                              if (state is FavoriteLoader) {
                                return VideoButton(
                                  iconPath: AppResource.heart,
                                  label: S.of(context).favorite,
                                  onTap: () {
                                    getIt.get<FavoriteBloc>().add(
                                          AddVideoToFavoriteEvent(
                                            video: widget.video,
                                          ),
                                        );
                                  },
                                  iconColor: widget.video?.isFavorite == true
                                      ? AppColor.carminePink
                                      : AppColor.white,
                                );
                              }
                              return VideoButton(
                                iconPath: AppResource.heart,
                                label: S.of(context).favorite,
                                onTap: () {
                                  getIt.get<FavoriteBloc>().add(
                                        AddVideoToFavoriteEvent(
                                          video: widget.video,
                                        ),
                                      );
                                },
                                iconColor: AppColor.white,
                              );
                            },
                          ),
                          SizedBox(
                            height: Constants.size25,
                          ),
                          ImageCircle(
                            imageUrl: widget.video?.thumbnailUrl,
                            width: Constants.size45,
                            height: Constants.size45,
                            isEdit: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const CircularLoading(
            color: AppColor.white,
          );
        },
      ),
    );
  }
}
