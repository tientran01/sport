import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class VideoButton extends StatelessWidget {
  final String? iconPath;
  final String? label;
  final VoidCallback? onTap;
  final Color? iconColor;
  const VideoButton({
    Key? key,
    this.iconPath,
    this.label,
    this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Image.asset(
            iconPath ?? AppResource.camera,
            color: iconColor,
            width: Constants.size25,
          ),
        ),
        TextView(
          text: label,
          fontSize: Constants.size15,
          textColor: AppColor.white,
        ),
      ],
    );
  }
}
