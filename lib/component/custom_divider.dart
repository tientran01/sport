import 'package:sport_app/resource/app_color.dart';
import 'package:sport_app/resource/app_style.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String textDisplay;
  final bool isOr;
  const CustomDivider({
    Key? key,
    required this.textDisplay,
    this.isOr = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * 0.8,
        child: Row(
          children: [
            buildDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                textDisplay,
                style: isOr
                    ? AppStyle.title.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.hDDDDDD,
                      )
                    : AppStyle.title
                        .copyWith(color: AppColor.h413F42, fontSize: 15.0),
              ),
            ),
            buildDivider()
          ],
        ),
      ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
      child: Divider(
        color: AppColor.hDDDDDD,
        height: 1.5,
      ),
    );
  }
}
