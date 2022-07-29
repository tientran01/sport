import 'package:flutter/material.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_text_field.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class CreateNewArticle extends StatelessWidget {
  final VoidCallback? onTap;
  const CreateNewArticle({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Image.asset(
                      AppResource.close,
                      width: Constants.size20,
                      color: AppColor.darkSilver,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: AppStrings.createNewArticle,
                      fontSize: Constants.size20,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: Constants.size20,
                    ),
                    CustomTextField(
                      title: AppStrings.titleArticle,
                      hintText: AppStrings.titleArticleInput,
                      onChanged: (String value) {},
                    ),
                    SizedBox(
                      height: Constants.size25,
                    ),
                    CustomTextField(
                      title: AppStrings.descArticle,
                      hintText: AppStrings.descArticleInput,
                      isMaxLine: true,
                      maxLine: 5,
                      onChanged: (String value) {},
                    ),
                    SizedBox(
                      height: Constants.size20,
                    ),
                    
                    Button(
                      bgColor: AppColor.black,
                      text: AppStrings.postArticle,
                      textColor: AppColor.white,
                      onTap: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
