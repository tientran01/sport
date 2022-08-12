import 'package:flutter/material.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:video_player/video_player.dart';

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
    videoPlayerController =
        VideoPlayerController.network("${widget.video?.videoUrl}");
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
      color: AppColor.white,
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
                  VideoPlayer(videoPlayerController),
                  IconButton(
                    onPressed: () {
                      pauseVideo();
                    },
                    icon: Image.asset(
                      AppResource.play,
                      color:
                          AppColor.white.withOpacity(isVideoPlaying ? 0 : 0.3),
                      width: Constants.size60,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CircularLoading(),
          );
        },
      ),
    );
  }
}
