import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sport_app/component/action.dart';
import 'package:sport_app/component/button.dart';
import 'package:sport_app/component/custom_image.dart';
import 'package:sport_app/component/text_view.dart';
import 'package:sport_app/l10n/lang.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/pages/base/base_view.dart';
import 'package:sport_app/permission/open_image_picker.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';

class EditYourArticleScreen extends StatefulWidget {
  const EditYourArticleScreen({Key? key}) : super(key: key);

  @override
  State<EditYourArticleScreen> createState() => _EditYourArticleScreenState();
}

class _EditYourArticleScreenState extends State<EditYourArticleScreen>
    with BaseView {
  String? imagePathChange;
  @override
  String? get titleAppBar => S.of(context).editYourArticle;
  @override
  bool? get isPop => true;
  @override
  Widget? get body {
    YourArticle? yourArticle =
        ModalRoute.of(context)?.settings.arguments as YourArticle?;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.size15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageLocal(
              imagePath: imagePathChange ?? yourArticle?.urlToImage,
            ),
            SizedBox(
              height: Constants.size15,
            ),
            TextView(
              text: yourArticle?.title,
              fontSize: Constants.size17,
              fontWeight: FontWeight.w800,
              lineNumber: 3,
            ),
            SizedBox(
              height: Constants.size30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "${S.of(context).description} :",
                  fontSize: Constants.size15,
                  textColor: AppColor.arsenic.withOpacity(0.5),
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(
                  height: Constants.size5,
                ),
                TextView(
                  text: yourArticle?.describe,
                  fontSize: Constants.size17,
                  lineNumber: 4,
                  textColor: AppColor.arsenic,
                )
              ],
            ),
            SizedBox(
              height: Constants.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "${S.of(context).publishedAt} :",
                  fontSize: Constants.size17,
                  textColor: AppColor.arsenic.withOpacity(0.5),
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(
                  width: Constants.size10,
                ),
                TextView(
                  text: DateFormat('yyyy-MM-dd').add_jm().format(
                        DateTime.parse(yourArticle?.publishedAt ?? ""),
                      ),
                  fontSize: Constants.size17,
                  lineNumber: 4,
                  textColor: AppColor.arsenic,
                )
              ],
            ),
            SizedBox(
              height: Constants.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "${S.of(context).author} :",
                  fontSize: Constants.size17,
                  textColor: AppColor.arsenic.withOpacity(0.5),
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(
                  width: Constants.size10,
                ),
                TextView(
                  text: yourArticle?.author,
                  fontSize: Constants.size17,
                  lineNumber: 4,
                  textColor: AppColor.arsenic,
                )
              ],
            ),
            SizedBox(
              height: Constants.size30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget? get floatingActionButton {
    return Padding(
      padding: EdgeInsets.only(left: Constants.size30),
      child: Button(
        text: AppLocalizations.of(context).done,
        width: MediaQuery.of(context).size.width,
        textColor: AppColor.white,
        bgColor: AppColor.viridianGreen,
        onTap: () {
          NavigationService.navigatorKey.currentState?.pop();
        },
      ),
    );
  }

  void showActionImage() {
    ActionComponent.shared.showActionUploadImage(
      context: context,
      onCamera: () {
        OpenImagePicker.getImage(
          getImageFromCamera: true,
          value: (String image) {
            setState(
              () {
                imagePathChange = image;
              },
            );
            NavigationService.navigatorKey.currentState?.pop();
          },
        );
      },
      onGalley: () {
        OpenImagePicker.getImage(
          getImageFromCamera: false,
          value: (String image) {
            setState(
              () {
                imagePathChange = image;
              },
            );
            NavigationService.navigatorKey.currentState?.pop();
          },
        );
      },
    );
  }
}
