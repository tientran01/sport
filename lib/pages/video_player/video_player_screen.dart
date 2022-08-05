import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
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
    List<Video> videos = Video.videos;
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
              child: playArea == true
                  ? CachedNetworkImage(
                      imageUrl:
                          videos.first.thumbnailUrl ?? AppNetwork.imageAvatar,
                      height: Constants.size300,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Constants.size25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                            text: AppStrings.hotNews,
                            fontSize: Constants.size25,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: Constants.size20,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(Constants.size10),
                                decoration: BoxDecoration(
                                  color: AppColor.gainsboro,
                                  borderRadius: BorderRadius.circular(
                                    Constants.size20,
                                  ),
                                ),
                                child: TextView(
                                  text: "${videos.length} videos",
                                  fontSize: Constants.size15,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
