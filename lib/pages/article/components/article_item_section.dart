import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/helper/timeago_helper.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleItem extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;
  const ArticleItem({
    Key? key,
    this.onTap,
    this.article,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.size135,
      padding: EdgeInsets.symmetric(
        vertical: Constants.size15,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(right: Constants.size10),
                child:
                    (article?.urlToImage == null || article?.urlToImage == "")
                        ? CustomImage(
                            imageUrl: AppNetwork.imageNewsPlaceholder,
                            width: Constants.size120,
                            height: Constants.size100,
                          )
                        : CustomImage(
                            imageUrl: article?.urlToImage,
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
                  article?.source?.name != null
                      ? Container(
                          margin: EdgeInsets.only(bottom: Constants.size10),
                          padding: EdgeInsets.symmetric(
                            horizontal: Constants.size15,
                            vertical: Constants.size5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.gainsboro,
                            borderRadius: BorderRadius.circular(
                              Constants.size20,
                            ),
                          ),
                          child: TextView(
                            text: article?.source?.name,
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
                      lineNumber: 2,
                    ),
                  ),
                  SizedBox(
                    height: Constants.size5,
                  ),
                  TextView(
                    text: TimeagoHelper.parseDatetime(article?.publishedAt),
                    textColor: AppColor.darkSilver.withOpacity(.5),
                    fontSize: Constants.size10,
                    fontWeight: FontWeight.w600,
                    lineNumber: 2,
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

class ArticleCustomWidthItem extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;
  const ArticleCustomWidthItem({
    Key? key,
    this.article,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Constants.size5),
        width: Constants.size250,
        height: Constants.size350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.size15),
          color: AppColor.gainsboro.withOpacity(0.3),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                  imageUrl: article?.urlToImage,
                  width: Constants.size250,
                  height: Constants.size150,
                ),
                SizedBox(
                  height: Constants.size5,
                ),
                TextView(
                  text: article?.title,
                  fontSize: Constants.size15,
                  fontWeight: FontWeight.w800,
                  textColor: AppColor.arsenic,
                ),
                SizedBox(
                  height: Constants.size5,
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomImage(
                        imageUrl: article?.urlToImage ?? "",
                        width: Constants.size60,
                        height: Constants.size60,
                      ),
                    ),
                    SizedBox(
                      width: Constants.size20,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: article?.author,
                            fontSize: Constants.size15,
                            textColor: AppColor.arsenic,
                          ),
                          SizedBox(
                            height: Constants.size5,
                          ),
                          TextView(
                            text: TimeagoHelper.parseDatetime(
                                article?.publishedAt),
                            fontSize: Constants.size10,
                            textColor: AppColor.darkSilver,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(Constants.size5),
                decoration: BoxDecoration(
                  color: AppColor.gainsboro,
                  borderRadius: BorderRadius.circular(Constants.size10),
                ),
                child: TextView(
                  text: article?.source?.name,
                  textColor: AppColor.black,
                  fontSize: Constants.size10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
