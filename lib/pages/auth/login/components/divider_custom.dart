import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class DividerCustom extends StatelessWidget {
  final String textDisplay;
  final bool isOr;
  const DividerCustom({
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
              padding: EdgeInsets.symmetric(horizontal: Constants.size10),
              child: TextView(
                text: textDisplay,
                textColor: AppColor.gainsboro,
                fontWeight: FontWeight.w600,
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
        color: AppColor.gainsboro,
        height: 1.5,
      ),
    );
  }
}
