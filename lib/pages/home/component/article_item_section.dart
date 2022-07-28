import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleItemSection extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? author;
  final String? category;
  final VoidCallback? onTap;
  const ArticleItemSection({
    Key? key,
    this.imagePath,
    this.title,
    this.author,
    this.category,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Constants.size10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(right: Constants.size10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        category != null
                            ? Container(
                                margin:
                                    EdgeInsets.only(bottom: Constants.size10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Constants.size10,
                                  vertical: Constants.size5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.gainsboro,
                                  borderRadius:
                                      BorderRadius.circular(Constants.size20),
                                ),
                                child: TextView(
                                  text: category,
                                  textColor: AppColor.arsenic,
                                  fontSize: Constants.size10,
                                ),
                              )
                            : Container(),
                        TextView(
                          text: title,
                          fontSize: Constants.size17,
                          fontWeight: FontWeight.w700,
                          textColor: AppColor.arsenic,
                          isMaxLine: true,
                          lineNumber: 2,
                        ),
                        SizedBox(
                          height: Constants.size5,
                        ),
                        Row(
                          children: [
                            TextView(
                              text: author,
                              textColor: AppColor.darkSilver.withOpacity(.5),
                              fontSize: Constants.size10,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: Constants.size10),
                    child: CustomImage(
                      imageUrl: AppNetwork.carouselImage_1,
                      width: Constants.size120,
                      height: Constants.size100,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
