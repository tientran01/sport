import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleItemSection extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;
  const ArticleItemSection({
    Key? key,
    this.onTap,
    this.article,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.size150,
      padding: EdgeInsets.symmetric(
        vertical: Constants.size15,
        horizontal: Constants.size20,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(right: Constants.size10),
                child: (article?.imageUrl == null || article?.imageUrl == "")
                    ? Container()
                    : CustomImage(
                        imageUrl: article?.imageUrl,
                        width: Constants.size120,
                        height: Constants.size100,
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: Constants.size10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  article?.categories != null
                      ? Container(
                          margin: EdgeInsets.only(bottom: Constants.size10),
                          padding: EdgeInsets.symmetric(
                            horizontal: Constants.size15,
                            vertical: Constants.size5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.gainsboro,
                            borderRadius:
                                BorderRadius.circular(Constants.size20),
                          ),
                          child: TextView(
                            text: article?.categories?.first,
                            textColor: AppColor.arsenic,
                            fontSize: Constants.size10,
                          ),
                        )
                      : Container(),
                  GestureDetector(
                    onTap: onTap,
                    child: TextView(
                      text: article?.title,
                      fontSize: Constants.size17,
                      fontWeight: FontWeight.w700,
                      textColor: AppColor.arsenic,
                      isMaxLine: true,
                      lineNumber: 2,
                    ),
                  ),
                  SizedBox(
                    height: Constants.size5,
                  ),
                  Row(
                    children: [
                      TextView(
                        text: article?.source,
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
        ],
      ),
    );
  }
}
