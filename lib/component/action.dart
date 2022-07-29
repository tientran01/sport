import 'package:flutter/cupertino.dart';
import 'package:sport_app/resource/resource.dart';

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
        title: const Text(AppStrings.chooseProfilePhoto),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: onCamera,
            child: const Text(
              AppStrings.camera,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: onGalley,
            child: const Text(
              AppStrings.gallery,
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(AppStrings.cancel),
          )
        ],
      ),
    );
  }
}
