import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class ProfileItem extends StatelessWidget {
  final String? text;
  final String? userInformation;
  final VoidCallback? onTap;
  const ProfileItem({Key? key, this.text, this.userInformation, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Constants.size15),
        child: Row(
          children: [
            TextView(
              text: text,
              fontSize: Constants.size15,
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextView(
                  text: userInformation,
                  fontSize: Constants.size15,
                  textColor: AppColor.darkSilver,
                ),
              ),
            ),
            SizedBox(
              width: Constants.size10,
            ),
            Image.asset(
              AppResource.rightArrow,
              width: Constants.size15,
              height: Constants.size15,
              color: AppColor.darkSilver,
            )
          ],
        ),
      ),
    );
  }
}
