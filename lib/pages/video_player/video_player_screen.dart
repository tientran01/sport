import 'package:flutter/material.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/video_player/component/video_detail.dart';
import 'package:sport_app/pages/video_player/component/video_tile.dart';
import 'package:sport_app/resource/resource.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Video video = ModalRoute.of(context)?.settings.arguments as Video;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        bgColor: Colors.transparent,
        leftIconColor: AppColor.white,
      ),
      backgroundColor: AppColor.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          VideoTile(
            video: video,
          ),
          SizedBox(
            height: Constants.size10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  height: Constants.size200,
                  child: VideoDetail(
                    video: video,
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
