import 'package:flutter/material.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/resource/resource.dart';

class Category {
  String? text;
  String? imageUrl;
  Color? color;
  Category({this.text, this.imageUrl, this.color});
  static List<Category> categories = [
    Category(
      text: Application.appleParamValue,
      color: AppColor.blue,
    ),
    Category(
      text: Application.bitcoinParamValue,
      color: AppColor.gainsboro,
    ),
    Category(
      text: Application.teslaParamValue,
      color: AppColor.jetStream,
    ),
  ];
}
