import 'package:sport_app/resource/app_style.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:flutter/material.dart';

class CustomNameSection extends StatelessWidget {
  final String nameSection;
  const CustomNameSection({
    Key? key,
    required this.nameSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Constants.size15,
        left: Constants.size10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            nameSection,
            style: AppStyle.nameSection,
          ),
        ],
      ),
    );
  }
}
