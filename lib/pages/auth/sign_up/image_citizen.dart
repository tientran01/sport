import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class ImageCitizen extends StatelessWidget {
  const ImageCitizen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextView(
          text: AppStrings.citizenID,
        ),
        SizedBox(
          height: Constants.size20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildFrameBorder(
              imagePath: AppResource.frame,
              text: AppStrings.photoSelfie,
            ),
            buildFrameBorder(
              imagePath: AppResource.camera,
              text: AppStrings.frontFace,
            ),
            buildFrameBorder(
              imagePath: AppResource.camera,
              text: AppStrings.backSide,
            ),
          ],
        )
      ],
    );
  }

  Widget buildFrameBorder({
    required String imagePath,
    required String text,
  }) {
    return DottedBorder(
      radius: Radius.circular(Constants.size5),
      color: AppColor.gainsboro,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.size20,
          vertical: Constants.size15,
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: Constants.sizeIcon,
            ),
            SizedBox(
              height: Constants.size10,
            ),
            TextView(
              text: text,
              textColor: AppColor.darkSilver,
            ),
          ],
        ),
      ),
    );
  }
}
