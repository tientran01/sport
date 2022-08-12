import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class VideoDetail extends StatelessWidget {
  final Video? video;
  const VideoDetail({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.size20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: video?.name,
            fontSize: Constants.size17,
            fontWeight: FontWeight.w700,
            textColor: AppColor.white,
            lineNumber: 2,
          ),
          SizedBox(
            height: Constants.size10,
          ),
          TextView(
            text: video?.description,
            fontWeight: FontWeight.w600,
            fontSize: Constants.size15,
            textColor: AppColor.darkSilver,
            lineNumber: 2,
          )
        ],
      ),
    );
  }
}
