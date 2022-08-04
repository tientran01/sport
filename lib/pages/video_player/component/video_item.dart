import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String url;
  final bool? play;
  const VideoItem({Key? key, required this.url, this.play = false})
      : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.url);
    initializeVideoPlayerFuture = controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoPlayer(controller),
          );
        } else {
          return const AspectRatio(
            aspectRatio: 16 / 9,
            child: Center(
              child: TextView(
                text: AppStrings.error,
              ),
            ),
          );
        }
      },
    );
  }
}
