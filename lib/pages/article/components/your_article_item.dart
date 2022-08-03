import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/resource/resource.dart';

// ignore: must_be_immutable
class YourArticleItem extends StatelessWidget {
  YourArticleItem({Key? key, this.yourArticle}) : super(key: key);
  YourArticle? yourArticle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: (BuildContext context, ArticleState state) {},
      builder: (context, state) {
        if (state is LoadingArticle) {
          return const CircularLoading();
        } else if (state is FailureArticle) {
          return Text("${state.error}");
        }
        // ignore: unnecessary_type_check
        if (state is ArticleState) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.size10,
              vertical: Constants.size5,
            ),
            child: Container(
              padding: EdgeInsets.all(Constants.size5),
              width: size.width,
              height: Constants.size120,
              decoration: BoxDecoration(
                color: AppColor.gainsboro.withOpacity(0.4),
                borderRadius: BorderRadius.all(
                  Radius.circular(Constants.size15),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      CustomImage(
                        imageUrl: yourArticle?.urlToImage,
                        width: Constants.size100,
                        height: Constants.size100,
                      ),
                      SizedBox(
                        width: Constants.size15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: yourArticle?.title,
                            textColor: AppColor.black,
                            fontWeight: FontWeight.w700,
                            fontSize: Constants.size17,
                          ),
                          TextView(
                            text: yourArticle?.description,
                            textColor: AppColor.darkSilver,
                            fontSize: Constants.size10,
                          ),
                          SizedBox(
                            height: Constants.size5,
                          ),
                          Row(
                            children: [
                              Container(
                                width: Constants.size30,
                                height: Constants.size30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.gainsboro,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: yourArticle?.urlToImage ??
                                      AppNetwork.imageAvatar,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                                text: yourArticle?.publishedAt,
                                fontSize: Constants.size10,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(Constants.size5),
                      child: Image.asset(
                        AppResource.delete,
                        width: Constants.size30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const CircularLoading();
        }
      },
    );
  }
}
