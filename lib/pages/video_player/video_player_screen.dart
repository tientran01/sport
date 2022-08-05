import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/pages/video_player/component/video_thumbnai_item.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class VideoPlayerScreen extends StatelessWidget {
  final bool? playArea;
  final Widget? child;
  const VideoPlayerScreen({Key? key, this.playArea, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Video> videos = AppStrings.videos;
    Video video = ModalRoute.of(context)?.settings.arguments as Video;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: Constants.size300,
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: Constants.size20,
              left: Constants.size20,
              child: GestureDetector(
                onTap: () {
                  NavigationService.navigatorKey.currentState?.pop();
                },
                child: Image.asset(
                  AppResource.leftArrow,
                  width: Constants.size30,
                  color: AppColor.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: Constants.size60,
                bottom: Constants.size45,
              ),
              child:CachedNetworkImage(
                      imageUrl: video.thumbnailUrl ?? AppNetwork.imageAvatar,
                      height: Constants.size300,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    )
                  
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.size15,
            vertical: Constants.size10,
          ),
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return VideoThumbnaiSmallItem(
                    video: videos.elementAt(index),
                  );
                },
                itemCount: videos.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
