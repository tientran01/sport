import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_resource.dart';
import 'package:sport_app/resource/app_strings.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final images = [
    AppResource.carousel_1,
    AppResource.carousel_2,
    AppResource.carousel_3,
    AppResource.carousel_4,
    AppResource.carousel_1,
    AppResource.carousel_2,
    AppResource.carousel_3,
    AppResource.carousel_4
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) =>
                buildSliderItem(images.elementAt(index), index),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              viewportFraction: 1,
              height: Constants.heightCarousel,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
          ),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildSliderItem(
    String imagePath,
    int index,
  ) =>
      Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Constants.size15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.size15),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black,
                  Colors.black45,
                  Colors.black12,
                  Colors.black.withOpacity(0),
                ],
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 40,
            child: Text(
              AppStrings.carouselTitle_1,
              style: AppStyle.carouselTitle,
            ),
          ),
        ],
      );

  Widget buildIndicator() => Container(
        margin: EdgeInsets.only(
          top: Constants.size10,
        ),
        child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: images.length,
          effect: const ExpandingDotsEffect(
            expansionFactor: 4,
            dotWidth: 6,
            dotHeight: 6,
            spacing: 4,
            activeDotColor: AppColor.h413F42,
          ),
        ),
      );
}
