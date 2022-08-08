import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_app_bar.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

import '../../model/video.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<Video> videos = AppStrings.videos;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.hotVideos,
        onPressedLeft: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: Constants.size5,
              horizontal: Constants.size10,
            ),
            width: size.width,
            padding: EdgeInsets.all(Constants.size5),
            decoration: BoxDecoration(
              color: AppColor.gainsboro,
              borderRadius: BorderRadius.circular(Constants.size10),
            ),
            child: Column(
              children: [
                CustomImage(
                  imageUrl: videos.elementAt(index).thumbnailUrl,
                  width: size.width,
                  height: Constants.size200,
                ),
                SizedBox(
                  height: Constants.size10,
                ),
                TextView(
                  text: videos.elementAt(index).name,
                  fontSize: Constants.size15,
                  lineNumber: 3,
                  fontWeight: FontWeight.w800,
                ),
                TextView(
                  text: videos.elementAt(index).description,
                  fontSize: Constants.size10,
                  lineNumber: 2,
                  textColor: AppColor.darkSilver,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
