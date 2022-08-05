import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class VideoThumbnaiSmallItem extends StatelessWidget {
  final Video? video;
  const VideoThumbnaiSmallItem({Key? key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Constants.size15),
      height: Constants.size100,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                CustomImage(
                  imageUrl: video?.thumbnailUrl,
                  width: Constants.size100,
                  height: Constants.size100,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(Constants.size5),
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppResource.play,
                        width: Constants.size10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: video?.name,
                  fontSize: Constants.size17,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: Constants.size5,
                ),
                TextView(
                  text: AppStrings.category,
                  fontSize: Constants.size15,
                  textColor: AppColor.gainsboro,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoThumbnaiLargeItem extends StatelessWidget {
  final Video? video;
  final VoidCallback? onTap;
  const VideoThumbnaiLargeItem({
    Key? key,
    this.video,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: Constants.size15),
        height: Constants.size100,
        child: Column(
          children: [
            Stack(
              children: [
                CustomImage(
                  imageUrl: video?.thumbnailUrl,
                  width: MediaQuery.of(context).size.width,
                  height: Constants.size200,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(Constants.size10),
                      decoration: BoxDecoration(
                        color: AppColor.white.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppResource.play,
                        width: Constants.size20,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(Constants.size5),
                    decoration: BoxDecoration(
                      color: AppColor.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(Constants.size10),
                    ),
                    child: TextView(
                      text: AppStrings.category,
                      fontSize: Constants.size10,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Constants.size15,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: video?.name,
                    fontSize: Constants.size15,
                    fontWeight: FontWeight.w700,
                    lineNumber: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
