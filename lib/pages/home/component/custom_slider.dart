import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_bloc.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_event.dart';
import 'package:sport_app/bloc/article/most_interested_news_bloc/most_interested_news_state.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/shimmer.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/main.dart';
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
    getIt.get<MostInterestedNewsBloc>().add(const MostInterestedNewsApiEvent());
  }

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<MostInterestedNewsBloc, MostInterestedNewsState>(
      bloc: getIt.get<MostInterestedNewsBloc>(),
      builder: (context, state) {
        if (state is MostInterestedNewsLoading) {
          return const ShimmerSlider();
        }
        if (state is MostInterestedNewsLoader) {
          if (state.articles == null) {
            return SizedBox(
              width: size.width,
              height: Constants.size200,
              child: Center(
                child: TextView(
                  text: AppStrings.error,
                  fontSize: Constants.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          } else {
            return SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    itemCount: state.articles?.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          NavigationService.navigatorKey.currentState
                              ?.pushNamed(
                            AppRouteName.detailArticle,
                            arguments: state.articles?.elementAt(index),
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CustomImage(
                              imageUrl:
                                  state.articles?.elementAt(index).urlToImage ??
                                      AppNetwork.imageNewsPlaceholder,
                              width: size.width,
                              height: Constants.size200,
                            ),
                            Positioned(
                              left: Constants.size30,
                              top: Constants.size45,
                              child: SizedBox(
                                width: Constants.size200,
                                child: TextView(
                                  text: state.articles?.elementAt(index).title,
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
                                  borderRadius:
                                      BorderRadius.circular(Constants.size15),
                                ),
                                child: TextView(
                                  text: state.articles
                                      ?.elementAt(index)
                                      .source
                                      ?.name,
                                  fontSize: Constants.size10,
                                ),
                              ),
                            ),
                          ],
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
        }
        return Center(
          child: Image.asset(
            AppResource.empty,
          ),
        );
      },
    );
  }
}
