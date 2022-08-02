import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class CategoryItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String? name;
  final String? imageUrl;

  const CategoryItem({
    Key? key,
    this.onTap,
    this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Constants.size120,
        width: Constants.size180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.size10),
          color: AppColor.white,
          image: DecorationImage(
            image: NetworkImage(
              imageUrl ?? AppNetwork.carouselImage_1,
            ),
            fit: BoxFit.fill,
            opacity: 0.8,
          ),
        ),
        child: Center(
          child: TextView(
            text: name,
            fontSize: Constants.size17,
            textColor: AppColor.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
