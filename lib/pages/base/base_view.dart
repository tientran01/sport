import 'package:flutter/material.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';

mixin BaseView<T extends StatefulWidget> on State<T> {
  String? titleAppBar;
  bool? isPop;
  PreferredSizeWidget? appBar;
  Widget? body;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void unfocus(BuildContext context) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.focusedChild?.unfocus();
      }
    }

    return GestureDetector(
      onTap: () => unfocus(context),
      child: Scaffold(
        appBar: appBar ??
            CustomAppBar(
              title: titleAppBar,
              isPop: isPop ?? false,
            ),
        body: body,
      ),
    );
  }
}
