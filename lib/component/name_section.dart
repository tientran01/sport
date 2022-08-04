import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class NameSection extends StatelessWidget {
  final String? titleSection;
  final String? text;
  final VoidCallback? onTap;
  const NameSection({Key? key, this.titleSection, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextView(
          text: titleSection,
          fontSize: Constants.size19,
          fontWeight: FontWeight.w700,
        ),
        const Spacer(),
        text != null
            ? GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    TextView(
                      text: text,
                      fontSize: Constants.size15,
                      fontWeight: FontWeight.w500,
                      textColor: AppColor.blue,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: Constants.size5),
                      child: Image.asset(
                        AppResource.rightArrow,
                        width: Constants.size15,
                        color: AppColor.blue,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
