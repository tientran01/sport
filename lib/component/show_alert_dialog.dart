import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/l10n/s.dart';
import 'package:sport_app/resource/resource.dart';

class ShowAlertDialog {
  ShowAlertDialog._();
  static Future showAlertDialog({
    required BuildContext context,
    required String title,
    String? content,
    String? cancelActionText,
    String? defaultActionText,
    VoidCallback? onPressed,
    Function(String)? onChanged,
    Widget? child,
  }) {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(content ?? ""),
          actions: <Widget>[
            InkWell(
              child: Text(
                cancelActionText ?? S.of(context).cancel,
              ),
              onTap: () => Navigator.of(context).pop(false),
            ),
            InkWell(
              child: Text(
                defaultActionText ?? S.of(context).done,
              ),
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    }
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: Constants.size15),
          child: content != null
              ? TextFormField(
                  decoration: InputDecoration(
                    hintText: content,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(Constants.size10),
                    ),
                    fillColor: AppColor.gainsboro,
                    filled: true,
                  ),
                  onChanged: onChanged,
                )
              : child,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelActionText ?? S.of(context).cancel,
            ),
          ),
          CupertinoDialogAction(
            onPressed: onPressed,
            child: Text(
              defaultActionText ?? S.of(context).done,
            ),
          ),
        ],
      ),
    );
  }
}
