import 'package:flutter/cupertino.dart';
import 'package:sport_app/l10n/lang.dart';

class ActionComponent {
  static final ActionComponent shared = ActionComponent._internal();
  ActionComponent._internal();

  void showActionUploadImage({
    required BuildContext context,
    required VoidCallback onCamera,
    required VoidCallback onGalley,
  }) {
    AppLocalizations local = AppLocalizations.of(context);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          AppLocalizations.of(context).uploadImage,
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: onCamera,
            child: Text(
              local.camera,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: onGalley,
            child: Text(
              local.gallery,
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(local.cancel),
          )
        ],
      ),
    );
  }
}
