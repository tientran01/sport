import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/resource/resource.dart';

class ArticleItem extends StatelessWidget {
  final Article? article;
  final VoidCallback? onTap;
  const ArticleItem({
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
