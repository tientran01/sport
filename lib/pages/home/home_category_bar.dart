import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class HomeCategoryBar extends StatefulWidget {
  const HomeCategoryBar({Key? key}) : super(key: key);

  @override
  State<HomeCategoryBar> createState() => _HomeCategoryBarState();
}

class _HomeCategoryBarState extends State<HomeCategoryBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            height: Constants.size45,
            decoration: BoxDecoration(
              color: AppColor.gainsboro.withOpacity(0.4),
              borderRadius: BorderRadius.circular(Constants.size20),
            ),
            padding: EdgeInsets.all(
              Constants.size5,
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(Constants.size20),
                color: AppColor.white,
              ),
              labelColor: AppColor.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                TextView(
                  text: AppStrings.feeds,
                  fontSize: Constants.size15,
                ),
                TextView(
                  text: AppStrings.popular,
                  fontSize: Constants.size15,
                ),
                TextView(
                  text: AppStrings.following,
                  fontSize: Constants.size15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
