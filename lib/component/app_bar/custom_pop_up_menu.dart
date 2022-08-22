import 'package:flutter/material.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/resource/resource.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final Function(String)? onSelected;
  const CustomPopupMenuButton({Key? key, this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    return PopupMenuButton(
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
          AppResource.sortAlpha,
          local.sortArticleByAplabet,
        ),
        customPopupMenuItem(
          2,
          AppResource.filter,
          local.filterArticleByDate,
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
  return PopupMenuItem(
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
