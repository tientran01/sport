import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/video_player/component/video_item.dart';
import 'package:sport_app/resource/resource.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Video> videos = Video.videos;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.hotVideos,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        cacheExtent: 1000,
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        itemCount: videos.isEmpty ? 0 : videos.length,
        itemBuilder: (BuildContext context, int index) => Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: VideoItem(
            play: true,
            url: videos.elementAt(index).videoUrl ?? "",
          ),
        ),
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
