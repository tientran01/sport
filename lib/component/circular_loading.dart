import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: AppStrings.loading,
                textColor: AppColor.black,
                fontSize: Constants.size15,
              ),
              SizedBox(
                height: Constants.size5,
              ),
              CupertinoActivityIndicator(
                color: Colors.transparent,
                radius: Constants.size15,
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: AppStrings.loading,
                textColor: AppColor.black,
                fontSize: Constants.size15,
              ),
              SizedBox(
                height: Constants.size5,
              ),
              const CircularProgressIndicator(),
            ],
          );
  }
}
