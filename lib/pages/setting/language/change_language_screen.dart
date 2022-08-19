import 'package:flutter/material.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/pages/setting/language/language.dart';
import 'package:sport_app/resource/resource.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  Language? language = Language.vietnamese;
  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context);
    return Scaffold(
      appBar:  CustomAppBar(
        title: local.chooseLanguage,
      ),
      body: Column(
        children: [
          ListTile(
            title: TextView(
              text: local.vietnamese,
              fontSize: Constants.size15,
            ),
            leading: Radio<Language>(
              value: Language.vietnamese,
              groupValue: language,
              onChanged: (Language? value) {
                setState(() {
                  language = value;
                });
              },
              activeColor: AppColor.viridianGreen,
            ),
          ),
          ListTile(
            title: TextView(
              text: local.english,
              fontSize: Constants.size15,
            ),
            leading: Radio<Language>(
              value: Language.english,
              groupValue: language,
              onChanged: (Language? value) {
                setState(() {
                  language = value;
                });
              },
              activeColor: AppColor.viridianGreen,
            ),
          ),
        ],
      ),
    );
  }
}
