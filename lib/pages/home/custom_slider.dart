import 'package:sport_app/component/custom_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_app/resource/resource.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final images = [
    AppNetwork.carouselImage_1,
    AppNetwork.carouselImage_2,
    AppNetwork.carouselImage_3,
    AppNetwork.carouselImage_4,
    AppNetwork.carouselImage_5
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) => buildSliderItem(
              images.elementAt(index),
              size.width,
              index,
            ),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              viewportFraction: 1,
              height: Constants.heightCarousel,
              onPageChanged: (index, reason) => setState(
                () => activeIndex = index,
              ),
            ),
          ),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildSliderItem(
    String imagePath,
    double width,
    int index,
  ) =>
      Stack(
        fit: StackFit.expand,
        children: [
          CustomImage(
            imageUrl: imagePath,
            width: width,
            height: Constants.heightCarousel,
          ),
          Positioned(
            left: 30,
            top: 40,
            child: Text(
              AppStrings.carouselTitle_1,
              style: AppStyle.lightDarkText(),
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
