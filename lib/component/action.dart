import 'package:flutter/cupertino.dart';
import 'package:sport_app/l10n/s.dart';

class ActionComponent {
  static final ActionComponent shared = ActionComponent._internal();
  ActionComponent._internal();

  void showActionUploadImage({
    required BuildContext context,
    required VoidCallback onCamera,
    required VoidCallback onGalley,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          S.of(context).uploadImage,
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: onCamera,
            child: Text(
              S.of(context).camera,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: onGalley,
            child: Text(
              S.of(context).gallery,
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(S.of(context).cancel),
          )
        ],
      ),
    );
  }
}
