import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:flutter/material.dart';

class CustomProductItem extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  const CustomProductItem({
    Key? key,
    this.width,
    this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.navigatorKey.currentState
          ?.pushNamed(AppRouteName.detaiProduct),
      child: Container(
        width: width ?? 170.0,
        height: height ?? 200.0,
        margin: EdgeInsets.only(right: Constants.size10),
        decoration: BoxDecoration(
          color: AppColor.hFFFFFF,
          borderRadius: BorderRadius.circular(
            Constants.size20,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.size15,
            vertical: Constants.size10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                child: Image.asset(
                  AppResource.bugger_1,
                  width: Constants.sizeImage,
                  height: Constants.sizeImage,
                ),
              ),
              SizedBox(
                height: Constants.size15,
              ),
              Expanded(
                child: Text(
                  AppStrings.pizza,
                  style: AppStyle.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "\$21.00",
                    style: AppStyle.price,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AppResource.star,
                        width: Constants.size20,
                        color: AppColor.hFFD24C,
                      ),
                      Text(
                        "4.8",
                        style: AppStyle.price,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
