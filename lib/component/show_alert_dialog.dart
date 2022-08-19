// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/l10n/lang.dart';
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
  }) {
    AppLocalizations local = AppLocalizations.of(context);
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(content ?? ""),
          actions: <Widget>[
            InkWell(
              child: Text(
                cancelActionText ?? local.cancel,
              ),
              onTap: () => Navigator.of(context).pop(false),
            ),
            InkWell(
              child: Text(
                defaultActionText ?? local.done,
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
              : Container(),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelActionText ?? local.cancel,
            ),
          ),
          CupertinoDialogAction(
            onPressed: onPressed,
            child: Text(
              defaultActionText ?? local.done,
            ),
          ),
        ],
      ),
    );
  }
}
