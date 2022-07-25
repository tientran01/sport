import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_resource.dart';
import 'package:sport_app/resource/app_strings.dart';
import 'package:sport_app/resource/constants.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: Constants.size60,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(
            Constants.size20,
          ),
          hintText: AppStrings.searchInput,
          border: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          fillColor: AppColor.hFFFFFF,
          filled: true,
          suffixIcon: Container(
            padding: EdgeInsets.all(Constants.size10),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                AppResource.search,
                width: Constants.size10,
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20.0),
    );
  }
}
