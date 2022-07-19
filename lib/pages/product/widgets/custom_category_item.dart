import 'package:sport_app/model/category.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:flutter/material.dart';

class CustomCategoryItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Category? category;
  const CustomCategoryItem({
    Key? key,
    this.onTap,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Constants.size15),
      ),
    );
  }
}
