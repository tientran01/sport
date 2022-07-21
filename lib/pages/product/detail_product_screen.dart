import 'package:sport_app/component/custom_button.dart';
import 'package:sport_app/pages/product/quantity_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import '../../component/custom_app_bar.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.detailProduct,
        onPressedLeft: () => NavigationService.navigatorKey.currentState?.pop(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildImage(),
            buildProductDetail(),
            SizedBox(
              height: Constants.size30,
            ),
            buildMultiButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildImage({String? imagePath}) {
    return SizedBox(
      height: Constants.size200,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Constants.size45),
                      topRight: Radius.circular(Constants.size45),
                    ),
                    color: AppColor.hFFFFFF,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(Constants.size15),
              width: Constants.size250,
              height: Constants.size250,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(-1, Constants.size10),
                  blurRadius: Constants.size10,
                )
              ]),
              child: Image.asset(
                imagePath ?? AppResource.bugger_1,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildProductDetail() {
    return Column(
      children: [
        Text(
          AppStrings.pizza,
          style: AppStyle.nameSection,
        ),
      ],
    );
  }

  Widget buildMultiButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Button(
          text: AppStrings.buyNow,
          bgColor: AppColor.hFFFFFF,
          textColor: AppColor.h000000,
          onPressed: () => QuantityDialog.showBottomDialog(context),
        ),
        const Button(
          text: AppStrings.addToCart,
          textColor: AppColor.hFFFFFF,
        ),
      ],
    );
  }
}
