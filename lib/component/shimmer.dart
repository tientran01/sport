import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class ShimmerSlider extends StatelessWidget {
  const ShimmerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Constants.size200,
      decoration: BoxDecoration(
        color: AppColor.gainsboro.withOpacity(0.4),
      ),
      child: Padding(
        padding: EdgeInsets.all(Constants.size20),
        child: Stack(
          children: [
            Positioned(
              bottom: Constants.size30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerItem(
                    width: Constants.size300,
                    height: Constants.size20,
                  ),
                  ShimmerItem(
                    width: Constants.size250,
                    height: Constants.size20,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ShimmerItem(
                width: Constants.size20,
                height: Constants.size10,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerArticleCustomWidth extends StatelessWidget {
  const ShimmerArticleCustomWidth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constants.size5),
      width: Constants.size250,
      height: Constants.size350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.size15),
        color: AppColor.gainsboro.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerItem(
            width: Constants.size250,
            height: Constants.size150,
          ),
          ShimmerItem(
            width: Constants.size200,
            height: Constants.size15,
          ),
          Row(
            children: [
              Flexible(
                child: ShimmerItem(
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
                    ShimmerItem(
                      height: Constants.size10,
                    ),
                    SizedBox(
                      height: Constants.size5,
                    ),
                    ShimmerItem(
                      height: Constants.size12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
class ShimmerItem extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  const ShimmerItem({Key? key, this.color, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Constants.size5),
      width: width ?? Constants.size120,
      height: height ?? Constants.size20,
      decoration: BoxDecoration(
        color: color ?? AppColor.gainsboro.withOpacity(0.4),
        borderRadius: BorderRadius.circular(Constants.size20),
      ),
    );
  }
}
