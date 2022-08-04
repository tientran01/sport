import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/shimmer.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleItemOfRow extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;
  const ArticleItemOfRow({
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
                        ? Container()
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
                            borderRadius:
                                BorderRadius.circular(Constants.size20),
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
                    text: article?.publishedAt,
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

class ArticleItemShimmer extends StatelessWidget {
  const ArticleItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.size135,
      padding: EdgeInsets.symmetric(
        vertical: Constants.size15,
        horizontal: Constants.size20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: Constants.size10),
              child: Shimmer(
                width: Constants.size120,
                height: Constants.size100,
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
                  Shimmer(
                    width: Constants.size45,
                    height: Constants.size10,
                  ),
                  SizedBox(
                    height: Constants.size10,
                  ),
                  Shimmer(
                    width: Constants.size350,
                    height: Constants.size20,
                  ),
                  SizedBox(
                    height: Constants.size5,
                  ),
                  Shimmer(
                    width: Constants.size180,
                    height: Constants.size20,
                  ),
                  SizedBox(
                    height: Constants.size10,
                  ),
                  Shimmer(
                    width: Constants.size120,
                    height: Constants.size10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ArticleItemOfColumn extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;
  const ArticleItemOfColumn({
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
                  fontWeight: FontWeight.w700,
                  textColor: AppColor.arsenic,
                ),
                SizedBox(
                  height: Constants.size5,
                ),
                Row(
                  children: [
                    Container(
                      width: Constants.size45,
                      height: Constants.size45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.gainsboro,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: article?.urlToImage ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.white,
                              width: Constants.size5,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Image.asset(
                            AppResource.profile,
                            width: Constants.size27,
                            height: Constants.size27,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Constants.size10,
                    ),
                    TextView(
                      text: AppStrings.channelDescription,
                      fontSize: Constants.size10,
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
