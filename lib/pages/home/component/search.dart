import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: Constants.size60,
      child: TextFormField(
        onTap: () {
          NavigationService.navigatorKey.currentState
              ?.pushNamed(AppRouteName.search);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: AppStrings.searchInput,
          hintStyle: TextStyle(
            color: AppColor.arsenic.withOpacity(0.3),
          ),
          border: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          fillColor: AppColor.arsenic.withOpacity(0.1),
          filled: true,
          suffixIcon: Container(
            padding: EdgeInsets.all(Constants.size10),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                AppResource.search,
                width: Constants.size10,
                color: AppColor.arsenic.withOpacity(0.3),
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
      borderRadius: BorderRadius.circular(Constants.size15),
    );
  }
}
