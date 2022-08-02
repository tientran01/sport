import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';

class Shimmer extends StatelessWidget {
  final double? height;
  final double? width;

  const Shimmer({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(Constants.size5),
      decoration: BoxDecoration(
        color: AppColor.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(Constants.size15),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  final double? height;
  final double? width;

  const ShimmerCircle({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(Constants.size5),
      decoration: BoxDecoration(
        color: AppColor.black.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}