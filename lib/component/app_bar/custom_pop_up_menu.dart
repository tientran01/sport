import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/resource/resource.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final void Function(String)? onSelected;
  const CustomPopupMenuButton({Key? key, this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Image.asset(
        AppResource.more,
        width: Constants.size20,
      ),
      onSelected: onSelected,
      offset: const Offset(0, 50),
      elevation: 2,
      itemBuilder: (context) => [
        customPopupMenuItem(
          1,
          AppResource.sort,
          AppStrings.filterNewArticleByDay,
        ),
        customPopupMenuItem(
          2,
          AppResource.sortAlpha,
          AppStrings.filterArticleByAlpha,
        ),
      ],
    );
  }
}

PopupMenuItem<String> customPopupMenuItem(
  int? value,
  String? iconPath,
  String? text,
) {
  return PopupMenuItem<String>(
    value: value.toString(),
    child: Row(
      children: [
        Image.asset(
          iconPath ?? "",
          width: Constants.size25,
        ),
        SizedBox(
          width: Constants.size5,
        ),
        TextView(
          text: text,
          fontSize: Constants.size15,
          fontWeight: FontWeight.w700,
          textColor: AppColor.darkSilver,
        ),
      ],
    ),
  );
}
