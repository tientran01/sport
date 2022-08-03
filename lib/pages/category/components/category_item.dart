import 'package:flutter/material.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/model/category.dart';
import 'package:sport_app/resource/resource.dart';

class CategoryItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Category? category;
  const CategoryItem({
    Key? key,
    this.onTap,
    this.category,
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
          color: category?.color,
        ),
        child: Center(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Constants.size10,
                  ),
                ),
                child: CustomImage(
                  imageUrl: category?.imageUrl ?? AppNetwork.carouselImage_1,
                  height: Constants.size180,
                ),
              ),
              Center(
                child: TextView(
                  text: category?.text,
                  fontSize: Constants.size17,
                  textColor: AppColor.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
