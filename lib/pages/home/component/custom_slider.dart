import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/bloc/article_state.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/component/circular_loading.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  void initState() {
    super.initState();
  }

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ArticleBloc, ArticleState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingArticle) {
          return const CircularLoading();
        } else if (state is FailureArticle) {
          return Center(
            child: Text("${state.error}"),
          );
        }
        // ignore: unnecessary_type_check
        if (state is ArticleState) {
          if (state.articles == null) {
            return const CircularLoading();
          } else {
            List<Article>? articles = state.articles;
            return SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    itemCount: articles?.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          NavigationService.navigatorKey.currentState
                              ?.pushNamed(
                            AppRouteName.detailArticle,
                            arguments: articles?.elementAt(index),
                          );
                        },
                        child: buildSliderItem(
                          articles?.elementAt(index),
                          size.width,
                          index,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      viewportFraction: 1,
                      height: Constants.size200,
                      onPageChanged: (index, reason) => setState(
                        () => activeIndex = index,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return const CircularLoading();
        }
      },
    );
  }

  Widget buildSliderItem(Article? article, double width, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomImage(
          imageUrl: article?.urlToImage,
          width: width,
          height: Constants.size200,
        ),
        Positioned(
          left: Constants.size30,
          top: Constants.size45,
          child: SizedBox(
            width: Constants.size200,
            child: TextView(
              text: article?.title,
              textColor: AppColor.white,
              fontSize: Constants.size17,
              fontWeight: FontWeight.w700,
              lineNumber: 5,
            ),
          ),
        ),
        Positioned(
          top: Constants.size15,
          right: Constants.size15,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Constants.size5,
              horizontal: Constants.size15,
            ),
            decoration: BoxDecoration(
              color: AppColor.ghostWhite.withOpacity(0.8),
              borderRadius: BorderRadius.circular(Constants.size15),
            ),
            child: TextView(
              text: article?.source?.name,
              fontSize: Constants.size10,
            ),
          ),
        ),
      ],
    );
  }
}
