import 'package:flutter/material.dart';
import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_strings.dart';
import 'package:sport_app/resource/constants.dart';

class QuantityDialog {
  QuantityDialog._();

  static void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: AppStrings.buyNowBarrierLabel,
      barrierDismissible: true,
      barrierColor: AppColor.h000000.withOpacity(0.6),
      transitionDuration: Duration(milliseconds: Constants.fourHundred),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  static Widget _buildDialogContent() {
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(Constants.size20),
        decoration: BoxDecoration(
          color: AppColor.hFFFFFF,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Constants.size15),
            topRight: Radius.circular(Constants.size15),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: Constants.size15),
            const Text(AppStrings.animationListDemo),
          ],
        ),
      ),
    );
  }
}