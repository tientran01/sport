import 'package:flutter/material.dart';
import 'package:sport_app/component/app_bar/custom_app_bar.dart';

mixin BaseView<T extends StatefulWidget> on State<T> {
  String? titleAppBar;
  bool? isPop;
  PreferredSizeWidget? appBar;
  Widget? body;
  Widget? floatingActionButton;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void initState() {
    super.initState();
  }

  void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () => {
        if (!currentFocus.hasPrimaryFocus)
          {
            currentFocus.focusedChild?.unfocus(),
          }
      },
      child: Scaffold(
        appBar: appBar ??
            CustomAppBar(
              title: titleAppBar,
              isPop: isPop ?? false,
            ),
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
